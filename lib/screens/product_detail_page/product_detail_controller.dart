import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../models/api_resp.dart';
import '../../models/product_list_model.dart';
import '../../services/product_listing_services.dart';

class ProductDetailViewController extends GetxController {
  RxBool isScreenProgress = true.obs;
  Rxn<ProductListing> product = Rxn<ProductListing>();
  int? id;
  RxInt selectedTab = 0.obs;
  RxBool isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments as int?;
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    if (id == null) return;
    isScreenProgress.value = true;
    final ApiResp resp = await ProductServices.getProductById(id!);

    if (resp.ok == true) {
      product.value = ProductListing.fromJson(resp.rdata);
    } else {
      print('Error fetching product details: ${resp.msgs}');
    }
    isScreenProgress.value = false;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  @override
  Future<void> refresh() {
    return Future.delayed(Duration(seconds: 5), () => fetchProductDetails());
  }
}
