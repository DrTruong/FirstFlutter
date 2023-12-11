import 'package:first_flutter/apps/getx_demo/models/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;

  Future<void> addProduct(Product item) async {
    if (item.id.trim().isNotEmpty || item.name.trim().isNotEmpty) {
      products.add(item);
    }
  }

  void getDefaultAllProducts() {
    final product_1 = Product(id: '1', name: 'Milk');
    final product_2 = Product(id: '2', name: 'Water');
    final product_3 = Product(id: '3', name: 'Juice');
    final product_4 = Product(id: '4', name: 'Coffee');
    products.value = [product_1, product_2, product_3, product_4];
  }
}
