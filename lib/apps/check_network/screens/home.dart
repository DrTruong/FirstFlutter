import 'package:first_flutter/apps/check_network/screens/body.dart';
import 'package:flutter/material.dart';

class CheckNetworkScreen extends StatelessWidget {
  const CheckNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Network'),
      ),
      body: const CheckNetworkBody(),
    );
  }
}
