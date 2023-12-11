import 'package:first_flutter/apps/flutter_isolate/screens/body.dart';
import 'package:flutter/material.dart';

class IsolateScreen extends StatelessWidget {
  const IsolateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Isolate'),
      ),
      body: const IsolateBody(),
    );
  }
}
