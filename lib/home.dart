import 'package:first_flutter/apps/animations_widget/screens/home.dart';
import 'package:first_flutter/apps/check_network/screens/home.dart';
import 'package:first_flutter/apps/download_file/screens/home.dart';
import 'package:first_flutter/apps/flutter_isolate/screens/home.dart';
import 'package:first_flutter/apps/getx_demo/screens/home.dart';
import 'package:first_flutter/apps/localstorage/screens/home.dart';
import 'package:first_flutter/apps/position_widget/screens/home.dart';
import 'package:first_flutter/apps/provider_demo/screens/home.dart';
import 'package:first_flutter/apps/refresh_loadmore_gridview/screens/home.dart';
import 'package:first_flutter/apps/store_objectbox/screens/home.dart';
import 'package:first_flutter/apps/stream_builder/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        margin: const EdgeInsets.only(left: 50, right: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              featureButton(
                context,
                screen: const ProviderHomeScreen(),
                name: 'Provider',
              ),
              featureButton(
                context,
                screen: const GetHomeScreen(),
                name: 'Getx Controller',
              ),
              featureButton(
                context,
                screen: const IsolateScreen(),
                name: 'Flutter Isolate',
              ),
              featureButton(
                context,
                screen: const LocalstorageScreen(),
                name: 'Local Storage',
              ),
              featureButton(
                context,
                screen: const RefreshLoadmoreGridViewScreen(),
                name: 'Refresh - Load more GridView',
              ),
              featureButton(
                context,
                screen: const PositionWidgetScreen(),
                name: 'Position Widget',
              ),
              featureButton(
                context,
                screen: const AnimationWidgetScreen(),
                name: 'Animation Widget',
              ),
              featureButton(
                context,
                screen: const StoreObjectBoxScreen(),
                name: 'Store ObjectBox',
              ),
              featureButton(
                context,
                screen: const CheckNetworkScreen(),
                name: 'Check network',
              ),
              featureButton(
                context,
                screen: const DownloadFileScreen(),
                name: 'Download file',
              ),
              featureButton(
                context,
                screen: const StreamBuilderScreen(),
                name: 'StreamBuilder',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget featureButton(BuildContext context,
      {required Widget screen, required String name}) {
    return ElevatedButton(
      onPressed: () => Get.to(() => screen),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name),
          const Spacer(),
          const Icon(Icons.arrow_forward_rounded),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
    );
  }
}
