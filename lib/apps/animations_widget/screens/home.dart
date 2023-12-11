import 'package:first_flutter/apps/animations_widget/screens/body.dart';
import 'package:flutter/material.dart';

class AnimationWidgetScreen extends StatelessWidget {
  const AnimationWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Widget'),
      ),
      body: const AnimationWidgetBody(),
    );
  }
}
