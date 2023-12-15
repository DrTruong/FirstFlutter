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
    IsolatedDownloadHandler.instance.initValueToCreateIsolate();
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
                      itemCount: counterController.indexList.length,
                      itemBuilder: (context, index) {
                        IsolatedDownloadHandler.instance.prepareForFirstRun();
                        counterController.urls.add((index % 2 == 0)
                            ? 'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
                            : 'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg');
                        if (counterController.downloadedIsolate[index]) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '${counter.isNotEmpty ? counterController.indexList[index] : '?'} - '),
                                  const Text('File đã được tải !'),
                                ],
                              ),
                              const SizedBox(height: 50),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '${counter.isNotEmpty ? counterController.indexList[index] : '?'} - '),
                                  DownloadItemWidget(
                                    key: Key(index.toString()),
                                    index: index,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                            ],
                          );
                        }
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
