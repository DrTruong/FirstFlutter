import 'package:first_flutter/apps/download_file/download_handler/isolated_download_handler.dart';
import 'package:flutter/material.dart';

class DownloadItemWidget extends StatefulWidget {
  const DownloadItemWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<DownloadItemWidget> createState() => _DownloadItemWidgetState();
}

class _DownloadItemWidgetState extends State<DownloadItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: IsolatedDownloadHandler
                .instance.downloadStreamControllers[widget.index].stream,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              } else if (snapshot.hasError) {
                return const Text('Lỗi !!!');
              } else {
                return const Text('Xin đợi...');
              }
            }),
          ),
        ],
      ),
    );
  }
}
