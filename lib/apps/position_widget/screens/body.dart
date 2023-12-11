import 'package:flutter/material.dart';

class PositionWidgetBody extends StatelessWidget {
  const PositionWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[500],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  height: 50,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                  height: 50,
                ),
              ),
            ],
          ),
          // Stack(
          //   children: [
          //     Positioned(
          //       top: 200,
          //       left: Get.width / 2 - 150 / 2,
          //       child: Stack(
          //         children: [
          //           Container(
          //             width: 150,
          //             height: 150,
          //             color: Colors.green[200],
          //           ),
          //           Positioned(
          //             bottom: 0,
          //             left: 0,
          //             child: Container(
          //               width: 100,
          //               height: 100,
          //               color: Colors.cyan[400],
          //             ),
          //           ),
          //           Positioned(
          //             top: 0,
          //             right: 0,
          //             child: Container(
          //               width: 50,
          //               height: 50,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(25),
          //                 color: Colors.red[400],
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
