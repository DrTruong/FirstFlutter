import 'package:flutter/material.dart';

class AnimationWidgetBody extends StatefulWidget {
  const AnimationWidgetBody({super.key});

  @override
  State<AnimationWidgetBody> createState() => _AnimationWidgetBodyState();
}

class _AnimationWidgetBodyState extends State<AnimationWidgetBody> {
  double animateHeight = 0;
  double animateWidth = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: animateWidth,
                height: animateHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.amber),
              ),
              SizedBox(width: animateHeight == 50 ? 20 : 0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    animateHeight = animateHeight == 0 ? 50 : 0;
                    animateWidth = animateWidth == 0 ? 50 : 0;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 100,
                  height: 100,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                animateHeight = animateHeight == 0 ? 50 : 0;
                animateWidth = animateWidth == 0 ? 50 : 0;
              });
            },
            child: Container(
              color: Colors.pink[100],
              child: Row(
                children: [
                  Container(
                    color: Colors.yellow,
                    width: 100,
                    height: 100,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
