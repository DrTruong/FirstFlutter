import 'dart:async';
import 'dart:isolate';

import 'package:get/get.dart';

class CountController extends GetxController {
  RxList<int> indexList = <int>[].obs;
  RxList<StreamController<String>> downloadStreamControllers =
      <StreamController<String>>[].obs;
  RxList<StreamController<String>> subStreamControllers =
      <StreamController<String>>[].obs;
  RxList<StreamController<String>> doneStreamControllers =
      <StreamController<String>>[].obs;
  RxList<bool> runIsolateList = <bool>[].obs;
  RxList<String> urls = <String>[].obs;
  RxList<Isolate> isolates = <Isolate>[].obs;
  RxList<Capability> capabilities = <Capability>[].obs;
  RxList<bool> downloadedIsolate = <bool>[].obs;

  void getFirstSubStream() {
    var subStream = downloadStreamControllers.sublist(0, 5);
    subStreamControllers.value = subStream;
  }
}
