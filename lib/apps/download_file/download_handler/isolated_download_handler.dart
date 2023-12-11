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
  IsolatedDownloadHandler(this.url, this.index, this.downloadFileStream) {
    firstRun();
  }

  final String url;
  final int index;
  final StreamController<String> downloadFileStream;

  Isolate? myIsolate;
  final counterController = getnef.Get.find<CountController>();

  void createNewIsolate(String url, String savePath) async {
    ReceivePort receivePort = ReceivePort();
    try {
      myIsolate = await Isolate.spawn(runDownloadTask, [
        receivePort.sendPort,
        url,
        savePath,
      ]);
    } catch (e) {
      debugPrint(e.toString());
      receivePort.close();
    }
    receivePort.listen(
      (message) {
        if (message == 'Đã tải xong') {
          counterController.indexList.remove(index);
          debugPrint('$index - xyz 1');
          counterController.doneStreamControllers.add(downloadFileStream);
          debugPrint('$index - xyz 2');
          counterController.doneStreamControllers.value =
              counterController.doneStreamControllers.toSet().toList();
          debugPrint('$index - xyz 3');
          downloadFileStream.close();
          counterController.subStreamControllers.remove(downloadFileStream);
          debugPrint('$index - xyz 4');
          for (var stream in counterController.downloadStreamControllers) {
            if (counterController.subStreamControllers.length < 5) {
              if (!counterController.doneStreamControllers.contains(stream) &&
                  !counterController.subStreamControllers.contains(stream)) {
                counterController.subStreamControllers.add(stream);
              }
            }
          }
          debugPrint('$index - xyz 5');
          if (myIsolate != null) {
            myIsolate?.kill(priority: Isolate.immediate);
          }
          debugPrint('$index - xyz end');
        } else {
          downloadFileStream.add(message);
        }
      },
    );

    // final dio = Dio();
    // try {
    //   Response response = await dio.get(
    //     url,
    //     options: Options(
    //       responseType: ResponseType.bytes,
    //       followRedirects: false,
    //       validateStatus: (status) {
    //         return status! < 500;
    //       },
    //     ),
    //     onReceiveProgress: (received, total) {
    //       downloadFileStream.add(
    //           '${(received / total * 100).toStringAsFixed(2).toString()} %');
    //       if (received == total) {
    //         downloadFileStream.add('Đã tải xong');
    //         counterController.counter.remove(index);
    //         counterController.streamControllers.remove(downloadFileStream);
    //       }
    //     },
    //   );
    //   debugPrint('download handle ==> ${response.headers}');
    //   File file = File(savePath);
    //   var raf = file.openSync(mode: FileMode.write);
    //   raf.writeFromSync(response.data);
    //   await raf.close();
    // } on DioException catch (_) {
    //   createNewIsolate(url, savePath);
    // } catch (e) {
    //   downloadFileStream.add(e.toString());
    // }
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
      debugPrint('download handle ==> ${response.headers}');
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
    if (counterController.doneStreamControllers.length !=
        counterController.downloadStreamControllers.length) {
      if (counterController.doneStreamControllers.isEmpty) {
        if (counterController.subStreamControllers
            .contains(downloadFileStream)) {
          var temporary = await getTemporaryDirectory();
          createNewIsolate(
              url, '${temporary.path}/${_getRandomString(10)}.mp4');
        }
      } else {
        if (counterController.subStreamControllers
                .contains(downloadFileStream) &&
            !counterController.doneStreamControllers
                .contains(downloadFileStream)) {
          var temporary = await getTemporaryDirectory();
          createNewIsolate(
              url, '${temporary.path}/${_getRandomString(10)}.mp4');
        }
      }
    }
  }
}