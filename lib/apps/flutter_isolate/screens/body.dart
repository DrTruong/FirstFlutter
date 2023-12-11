import 'dart:isolate';
import 'package:first_flutter/apps/getx_demo/controllers/product_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsolateBody extends StatefulWidget {
  const IsolateBody({super.key});

  @override
  State<IsolateBody> createState() => _IsolateBodyState();
}

class _IsolateBodyState extends State<IsolateBody> {
  String result = '';
  Isolate? myIsolate;
  final student = Student(name: 'Truong', age: 24);
  final productController = Get.find<ProductController>();
  bool detectTaskIsolate = false;
  static String test1 = 'hehehe';
  static int test2 = 123;

  @override
  void initState() {
    super.initState();
    // productController.getDefaultAllProducts();
    // _runCompute();
    runIsolate(1000000000, productController);
  }

  @override
  void dispose() {
    if (myIsolate != null) {
      myIsolate!.kill(priority: Isolate.immediate);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.amberAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                result = '0';
              });
              // var r = 1;
              // for (var i = 1; i < 1000000000; i++) {
              //   r += i;
              // }
              final r = await task(test1, test2);
              setState(() {
                detectTaskIsolate = false;
                result = '$r';
              });
            },
            child: const Text('Test 1'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                result = '0';
              });
              runIsolate(1000000000, productController);
            },
            child: const Text('Test 2'),
          ),
          Text('Sum is: $result'),
          const SizedBox(height: 20),
          Text(detectTaskIsolate ? 'Isolate' : 'Normal'),
        ],
      ),
    );
  }

  void runIsolate(int value, ProductController product) async {
    final ReceivePort receivePort = ReceivePort();

    try {
      myIsolate = await Isolate.spawn(
          runTask, [receivePort.sendPort, value, product, test1, test2]);
    } catch (e) {
      debugPrint('Isolate failed: $e');
      receivePort.close();
    }
    receivePort.listen((message) {
      setState(() {
        detectTaskIsolate = true;
        result = '$message';
      });
    });
  }

  static void runTask(List<dynamic> agrs) async {
    SendPort sendPort = agrs[0];
    // int r = 1;
    // for (var i = 1; i < agrs[1]; i++) {
    //   r += i;
    // }
    int r = await task(agrs[3], agrs[4]);
    sendPort.send(r);
  }

  static int testnef(int value) {
    int r = 1;
    for (var i = 1; i < value; i++) {
      r += i;
    }
    return r;
  }

  // phải thực hiện huỷ task trước khi pop Navigator
  // ignore: unused_element
  void _runCompute() async {
    int result = await compute(testnef, 1000000000);
    setState(() {
      this.result = '$result';
    });
  }

  static Future<int> task(String test3, int test4) async {
    int r = 1;
    for (var i = 1; i < 1000000000; i++) {
      r += i;
    }
    debugPrint('==> $test1 - $test2');
    return r;
  }
}

class Student {
  Student({this.name, this.age});
  String? name;
  int? age;
}
