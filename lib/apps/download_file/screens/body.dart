import 'dart:async';

import 'package:first_flutter/apps/download_file/controllers/count_controller.dart';
import 'package:first_flutter/apps/download_file/download_handler/isolated_download_handler.dart';
import 'package:first_flutter/apps/download_file/widgets/download_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadFileBody extends StatefulWidget {
  const DownloadFileBody({super.key});

  @override
  State<DownloadFileBody> createState() => _DownloadFileBodyState();
}

class _DownloadFileBodyState extends State<DownloadFileBody> {
  String resultString = '';
  bool isPause = false;
  final counterController = Get.find<CountController>();

  @override
  void initState() {
    super.initState();
    if (counterController.downloadStreamControllers.isEmpty) {
      for (int i = 0; i < 5; i++) {
        final newStream = StreamController<String>.broadcast();
        counterController.downloadStreamControllers.add(newStream);
        counterController.indexList.add(i);
      }
      debugPrint(
          '==> length: ${counterController.downloadStreamControllers.length.toString()}');
      counterController.getFirstSubStream();
      debugPrint('==> done');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Obx(
          () => Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: counterController.indexList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      color: Colors.amber,
                      width: 10,
                      height: 5,
                    ),
                    Text(counterController.indexList[index].toString()),
                  ],
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  CircularProgressIndicator(),
                ],
              ),
              const SizedBox(height: 50),
              Obx(
                () {
                  List<int> counter = counterController.indexList.value;
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          counterController.downloadStreamControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '${counter.isNotEmpty ? counterController.indexList[index] : '?'} - '),
                                DownloadItemWidget(
                                  key: Key(index.toString()),
                                  isolatedDownload: IsolatedDownloadHandler(
                                    (index % 2 == 0)
                                        ? 'https://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'
                                        : 'https://files.stm.devitkv2.com:9000/stm-dev/9b7569d4-d29f-4ce1-b327-ae9a4a1cb68c/2023/12/782ea6e1-facb-4e97-8e7a-3f2740263bd0/chat/video/3e31b495-f13a-4406-b584-9456230b5a5f.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=stmminio%2F20231206%2Fa%2Fs3%2Faws4_request&X-Amz-Date=20231206T074741Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ec6f2ee98af52f26352e407fc522610f9edcfcf02cfa94d43cc978550992577e',
                                    index,
                                    counterController
                                        .downloadStreamControllers[index],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
