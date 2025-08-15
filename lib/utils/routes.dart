import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/edit_product/edit_product_binding.dart';
import '../screens/edit_product/edit_product_view.dart';
import '../screens/product_detail_page/product_detail_binding.dart';
import '../screens/product_detail_page/product_detail_view.dart';
import '../screens/product_list/product_list_bindings.dart';
import '../screens/product_list/product_list_view.dart';
import '../splash_screen.dart';


class Routes {
  static const splash = '/';
  static const productlisting = '/productListing';
  static const productdetail = '/productDetail';
  static const editproduct = '/editProduct';


  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      binding: ProductListingBindings(),
      name: productlisting,
      page: () =>  ProductListingView(),
    ),
    GetPage(
      binding: ProductDetailBindings(),
      name: productdetail,
      page: () =>  ProductDetailView(),
    ),
    GetPage(
      binding: EditProductBindings(),
      name: editproduct,
      page: () => EditProductView(),
    ),

  ];

}