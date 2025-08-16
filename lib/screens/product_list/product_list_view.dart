import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sinrorobotics_machine_test/screens/product_list/product_list_controller.dart';
import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class ProductListingView extends GetView<ProductListingController> {
  const ProductListingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyUtils.hideKeyboard(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.menu, color: MyTheme.appColor),
            onPressed: () => Get.back(),
          ),
          title: const Text('Product Listing',
              style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: MyTheme.appColor),
              onPressed: () {},
            ),
          ],
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isScreenProgress.value) {
            return const Center(child: RoundedLoader());
          }
          final products = controller.proData;
          if (products.isEmpty) {
            return const Center(child: MAResultEmpty(msg: 'Results Empty'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Discover our exclusive\nproducts',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "In this market place, you will find various\ntechnics in the cheapest price",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: Get.height * .015,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.productdetail,
                            arguments: product.id,
                            preventDuplicates: true,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 130,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      child: (product.images != null &&
                                              product.images!.isNotEmpty)
                                          ? Image.network(
                                              product.images!.first,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/img_2.png',
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              'assets/images/img_2.png',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 8,
                                    child: Obx(() => GestureDetector(
                                          onTap: () =>
                                              controller.toggleFavorite(index),
                                          child: Icon(
                                            Icons.favorite,
                                            color: controller.favorites[index]
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              // Product details
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title ?? "----",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: MyTheme.myBlueDark,
                                        fontSize: Get.height * .018,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(height: 8),
                                    Text(
                                      product.description ?? '',
                                      style: TextStyle(color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.currency_rupee_outlined,
                                            size: 14),
                                        Text(
                                          product.price.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: Get.height * .018,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
