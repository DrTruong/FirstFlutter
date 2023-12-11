import 'package:first_flutter/apps/store_objectbox/screens/body.dart';
import 'package:flutter/material.dart';

class StoreObjectBoxScreen extends StatelessWidget {
  const StoreObjectBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store ObjectBox'),
      ),
      body: const StoreObjectBoxBody(),
    );
  }
}
