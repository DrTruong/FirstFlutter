import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:first_flutter/apps/download_file/controllers/count_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getnef;
import 'package:path_provider/path_provider.dart';

class IsolatedDownloadHandler {
  static IsolatedDownloadHandler? _instance;

  IsolatedDownloadHandler._();

  static IsolatedDownloadHandler get instance {
    _instance ??= IsolatedDownloadHandler._();
    return _instance!;
  }

  List<String> urls = [];
  List<StreamController<String>> downloadStreamControllers = [];
  StreamController<bool> stopIsolateStreamController =
      StreamController<bool>.broadcast();

  final counterController = getnef.Get.find<CountController>();

  void createNewIsolate(
    int index,
    String url,
    String savePath,
    StreamController<String> downloadFileStream,
    StreamController<bool> stopIsolateStreamController,
  ) async {
    ReceivePort receivePort = ReceivePort();
    Capability capability = Capability();
    try {
      debugPrint('downloading... $index');
      final newIsolate = await Isolate.spawn(runDownloadTask, [
        receivePort.sendPort,
        url,
        savePath,
      ]);
      counterController.isolates.add(newIsolate);
      counterController.capabilities.add(capability);
    } catch (e) {
      debugPrint(e.toString());
      receivePort.close();
    }
    stopIsolateStreamController.stream.listen((event) {
      final isolate = counterController.isolates[index];
      final capability = counterController.capabilities[index];
      if (event) {
        if (event && counterController.runIsolateList[index]) {
          debugPrint('paused - $event - $index');
          isolate.pause(capability);
        } else {
          debugPrint('resume - $event - $index');
          isolate.resume(capability);
        }
      } else {
        isolate.resume(capability);
      }
    });
    receivePort.listen(
      (message) async {
        if (message == 'Đã tải xong') {
          await stoppingDownloadIsolate(true);
          counterController.downloadedIsolate[index] = true;
          debugPrint('heheh - $index');
          downloadFileStream.add(message);
          counterController.runIsolateList[index] = false;
          downloadFileStream.close();
          counterController.doneStreamControllers.add(downloadFileStream);
          counterController.subStreamControllers.remove(downloadFileStream);
          await setDoneStreamControllersUnique();
          await addNextDownloadIsolate(savePath);
          await stoppingDownloadIsolate(false);
          debugPrint('killed - $index');
        } else {
          downloadFileStream.add(message);
        }
      },
    );
  }

  static void runDownloadTask(List<dynamic> args) async {
    final SendPort sendPort = args[0];
    final dio = Dio();
    var error = '';
    try {
      Response response = await dio.get(
        args[1],
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
        onReceiveProgress: (received, total) {
          sendPort.send(
              '${(received / total * 100).toStringAsFixed(2).toString()} %');
          if (received == total) {
            sendPort.send('Đã tải xong');
          }
        },
      );
      File file = File(args[2]);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } on DioException catch (_) {
      runDownloadTask(args);
    } catch (e) {
      error = e.toString();
      sendPort.send(error);
    }
  }

  String _getRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }

  void firstRun() async {
    debugPrint('firstrun ==> start');
    debugPrint(
        'firstrun ==> ${counterController.downloadStreamControllers.length}');
    for (int i = 0;
        i < counterController.downloadStreamControllers.length;
        i++) {
      final stream = counterController.downloadStreamControllers[i];
      final url = counterController.urls[i];
      if (counterController.subStreamControllers.contains(stream)) {
        var temporary = await getTemporaryDirectory();
        createNewIsolate(
          i,
          url,
          '${temporary.path}/${_getRandomString(10)}.mp4',
          stream,
          stopIsolateStreamController,
        );
        url == 'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
            ? debugPrint('firstRun - link 1')
            : debugPrint('firstRun - link 2');
      }
    }
    debugPrint('\n');
  }

  Future<void> addNextDownloadIsolate(String savePath) async {
    if (counterController.doneStreamControllers.length <=
        counterController.downloadStreamControllers.length) {
      debugPrint('vaonef');
      for (int i = 0;
          i < counterController.downloadStreamControllers.length;
          i++) {
        final stream = counterController.downloadStreamControllers[i];
        final url = counterController.urls[i];
        final downloadFileStream =
            counterController.downloadStreamControllers[i];
        debugPrint('==> ${counterController.subStreamControllers.length}');
        if (counterController.subStreamControllers.length < 5) {
          if (!counterController.doneStreamControllers.contains(stream) &&
              !counterController.subStreamControllers.contains(stream)) {
            counterController.subStreamControllers.add(stream);
            debugPrint(counterController.downloadStreamControllers
                .indexOf(stream)
                .toString());
            createNewIsolate(
              counterController.downloadStreamControllers.indexOf(stream),
              url,
              savePath,
              downloadFileStream,
              stopIsolateStreamController,
            );
            url == 'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
                ? debugPrint(
                    'nextRun - link 1 - index ${counterController.subStreamControllers.indexOf(stream)}')
                : debugPrint(
                    'nextRun - link 2 - index ${counterController.subStreamControllers.indexOf(stream)}');
          }
        }
      }
      debugPrint('\n');
    }
  }

  Future<void> stoppingDownloadIsolate(bool isRun) async {
    stopIsolateStreamController.sink.add(isRun);
  }

  Future<void> setDoneStreamControllersUnique() async {
    counterController.doneStreamControllers.value =
        counterController.doneStreamControllers.toSet().toList();
  }

  void initValueToCreateIsolate() {
    if (counterController.downloadStreamControllers.isEmpty) {
      for (int i = 0; i < 100; i++) {
        counterController.indexList.add(i);
        counterController.runIsolateList.add(true);
        counterController.downloadedIsolate.add(false);
      }
      IsolatedDownloadHandler.instance.downloadStreamControllers =
          counterController.downloadStreamControllers;
    }
  }

  void prepareForFirstRun() {
    if (counterController.downloadStreamControllers.length <
        counterController.indexList.length) {
      final newStream = StreamController<String>.broadcast();
      counterController.downloadStreamControllers.add(newStream);
    }
    if (counterController.downloadStreamControllers.length == 5) {
      counterController.getFirstSubStream();
      if (counterController.subStreamControllers.isNotEmpty) {
        IsolatedDownloadHandler.instance.firstRun();
      }
    }
  }
}
