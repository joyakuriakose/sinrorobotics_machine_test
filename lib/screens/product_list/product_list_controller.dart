import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../models/api_resp.dart';
import '../../models/product_list_model.dart';
import '../../services/product_listing_services.dart';

class ProductListingController extends GetxController {
  RxBool isScreenProgress = true.obs;
  RxList<ProductListing> proData = <ProductListing>[].obs;
  RxList<bool> favorites = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    initialProductList();
  }


  Future<void> initialProductList() async {
    try {
      final ApiResp resp = await ProductServices.getproductList();
      if (resp.ok && resp.rdata is Map<String, dynamic>) {
        final prodDetails = ProductListingModel.fromJson(resp.rdata);
        proData.assignAll(prodDetails.products ?? []);
        favorites.value = List.generate(proData.length, (_) => false);
      } else {
        print('Invalid or empty API response: ${resp.rdata}');
      }
    } catch (e) {
      print('Error fetching product data: $e');
    } finally {
      isScreenProgress.value = false;
    }
  }
  void updateProductInList(ProductListing updatedProduct) {
    final index = proData.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      proData[index] = updatedProduct;
      proData.refresh(); // tell GetX to update UI
    }
  }


  void toggleFavorite(int index) {
    favorites[index] = !favorites[index];
  }
}