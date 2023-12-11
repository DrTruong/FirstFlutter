import 'package:first_flutter/apps/download_file/controllers/count_controller.dart';
import 'package:first_flutter/apps/getx_demo/controllers/product_controller.dart';
import 'package:first_flutter/apps/provider_demo/providers/title_provider.dart';
import 'package:first_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  Get.put(ProductController());
  Get.put(CountController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => TitleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
