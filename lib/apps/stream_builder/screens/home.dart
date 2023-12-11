import 'package:first_flutter/apps/stream_builder/screens/body.dart';
import 'package:flutter/material.dart';

class StreamBuilderScreen extends StatelessWidget {
  const StreamBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Builder'),
      ),
      body: const StreamBuilderBody(),
    );
  }
}
