import 'package:first_flutter/apps/download_file/screens/body.dart';
import 'package:flutter/material.dart';

class DownloadFileScreen extends StatelessWidget {
  const DownloadFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download File'),
      ),
      body: const DownloadFileBody(),
    );
  }
}
