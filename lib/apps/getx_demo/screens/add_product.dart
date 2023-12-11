import 'package:first_flutter/apps/getx_demo/controllers/product_controller.dart';
import 'package:first_flutter/apps/getx_demo/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _productController = Get.find<ProductController>();
  late TextEditingController _idTextController;
  late TextEditingController _nameTextController;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _nameTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 50, right: 50),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _idTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Id'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _productController.addProduct(
                  Product(
                    id: _idTextController.text,
                    name: _nameTextController.text,
                  ),
                );
                FocusManager.instance.primaryFocus?.unfocus();
                Get.back();
              },
              child: const Text('Add product'),
            )
          ],
        ),
      ),
    );
  }
}
