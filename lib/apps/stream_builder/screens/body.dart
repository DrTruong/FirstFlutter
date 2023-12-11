import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StreamBuilderBody extends StatefulWidget {
  const StreamBuilderBody({super.key});

  @override
  State<StreamBuilderBody> createState() => _StreamBuilderBodyState();
}

class _StreamBuilderBodyState extends State<StreamBuilderBody> {
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    startStream();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[200],
      child: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Stream Has Error'),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Stream random number data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Random number: ${snapshot.data}')
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void startStream() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      var randomNumber = 0 + Random().nextInt(100 - 0);
      _streamController.sink.add(randomNumber);
    });
  }
}
