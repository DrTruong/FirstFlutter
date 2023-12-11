import 'package:first_flutter/apps/position_widget/screens/body.dart';
import 'package:flutter/material.dart';

class PositionWidgetScreen extends StatelessWidget {
  const PositionWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Position wiget screen'),
      ),
      body: const PositionWidgetBody(),
    );
  }
}
