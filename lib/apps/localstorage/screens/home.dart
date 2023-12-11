import 'package:first_flutter/apps/localstorage/screens/body.dart';
import 'package:flutter/material.dart';

class LocalstorageScreen extends StatelessWidget {
  const LocalstorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Storage Demo'),
      ),
      body: const LocalStorageBody(),
    );
  }
}
