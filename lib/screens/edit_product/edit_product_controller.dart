import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../services/product_listing_services.dart';

class EditProductController extends GetxController {
  RxBool isScreenProgress = false.obs; // false by default so UI loads immediately
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late int productId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    productId = args['id'] ?? 0;
    titleController.text = args['title'] ?? '';
    priceController.text = args['price']?.toString() ?? '';
    descriptionController.text = args['description'] ?? '';
  }

  Future<void> updateProduct() async {
    isScreenProgress.value = true;

    final data = {
      "title": titleController.text.trim(),
      "price": double.tryParse(priceController.text.trim()) ?? 0,
      "description": descriptionController.text.trim(),
    };

    final resp = await ProductServices.updateProduct(productId, data);

    isScreenProgress.value = false;

    if (resp.ok) {
      Get.snackbar("Success", "Product updated successfully");
      Get.back(result: true); // return true so details page knows to refresh
    } else {
      Get.snackbar("Error", "Failed to update product");
    }

  }
}

