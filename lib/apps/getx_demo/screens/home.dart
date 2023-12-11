import 'package:first_flutter/apps/getx_demo/controllers/product_controller.dart';
import 'package:first_flutter/apps/getx_demo/screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetHomeScreen extends StatefulWidget {
  const GetHomeScreen({super.key});

  @override
  State<GetHomeScreen> createState() => _GetHomeScreenState();
}

class _GetHomeScreenState extends State<GetHomeScreen> {
  final _productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getx Demo'),
        actions: [
          IconButton(
            onPressed: () {
              _productController.getDefaultAllProducts();
            },
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      body: Container(
        color: Colors.orangeAccent,
        // width: double.maxFinite,
        child: Obx(
          () => ListView.builder(
            itemCount: _productController.products.length + 1,
            itemBuilder: ((ctx, index) {
              if (index < _productController.products.length) {
                return ListTile(
                  leading: Text(_productController.products[index].id),
                  title: Text(_productController.products[index].name),
                  trailing: const Icon(Icons.arrow_right),
                );
              } else {
                return ElevatedButton(
                  onPressed: () {
                    Get.to(() => const AddProductScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add'),
                      Icon(Icons.add),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
