import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sinrorobotics_machine_test/screens/product_detail_page/product_detail_controller.dart';

class ProductDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailViewController>(
          () => ProductDetailViewController(),
    );
  }
}