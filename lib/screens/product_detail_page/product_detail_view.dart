import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sinrorobotics_machine_test/components/app_buttons.dart';
import 'package:sinrorobotics_machine_test/components/rounded_loader.dart';
import 'package:sinrorobotics_machine_test/screens/product_detail_page/product_detail_controller.dart';
import '../../components/app_refresh.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';

class ProductDetailView extends GetView<ProductDetailViewController> {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: MyUtils.hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: MyTheme.appColor),
            onPressed: () => Get.back(),
          ),
          title: const Text('Product Details',
              style: TextStyle(color: Colors.black)),
          actions: [
            Obx(() => GestureDetector(
                  onTap: controller.toggleFavorite,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      controller.isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: controller.isFavorite.value
                          ? Colors.red
                          : MyTheme.myBlueDark,
                    ),
                  ),
                )),
          ],
          centerTitle: true,
        ),
        body: AppRefresh(
          refreshFunction: controller.refresh,
          child: Column(
            children: [
              Obx(() {
                if (controller.isScreenProgress.value) {
                  return const Center(child: RoundedLoader());
                }

                final product = controller.product.value;
                if (product == null) {
                  return const Center(child: Text('No product found'));
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Image + Thumbnails
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: product.images != null &&
                                      product.images!.isNotEmpty
                                  ? Image.network(
                                      product.images!.first,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/img_2.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(3, (index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: product.images != null &&
                                                product.images!.isNotEmpty
                                            ? Image.network(
                                                product.images!.first,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/img_2.png',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        '\$ ${product.price ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.myBlueDark,
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(product.title ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 16),

                      // --- Tab Buttons ---
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.selectedTab.value = 0,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.selectedTab.value == 0
                                        ? MyTheme.appColor
                                        : Colors.grey[300],
                              ),
                              child: Text(
                                "Full Specification",
                                style: TextStyle(
                                  color: controller.selectedTab.value == 0
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.selectedTab.value = 1,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.selectedTab.value == 1
                                        ? MyTheme.appColor
                                        : Colors.grey[300],
                              ),
                              child: Text(
                                "Reviews",
                                style: TextStyle(
                                  color: controller.selectedTab.value == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // --- Tab Content ---
                      Obx(() {
                        if (controller.selectedTab.value == 0) {
                          return Text(
                            product.description ?? '',
                            style: const TextStyle(color: Colors.grey),
                          );
                        } else {
                          return Text('Rating: ${product.rating ?? 'N/A'}');
                        }
                      }),

                      const SizedBox(height: 8),
                      Text('Category: ${product.category ?? 'N/A'}'),
                      Text('Rating: ${product.rating ?? 'N/A'}'),
                      Text('Stock: ${product.stock ?? 'N/A'}'),

                      const SizedBox(height: 16),
                      Center(
                        child: MAButton(
                          buttonPress: () async {
                            final updated = await Get.toNamed(
                              '/editProduct',
                              arguments: {
                                'id': controller.id,
                                'title': controller.product.value?.title ?? '',
                                'price': controller.product.value?.price ?? 0,
                                'description':
                                    controller.product.value?.description ?? '',
                              },
                            );

                            if (updated == true) {
                              controller.fetchProductDetails();
                            }
                          },
                          text: 'Edit',
                          height: 40,
                          width: 150,
                          clipBehavior: 5,
                          radius: 5,
                          fontSize: 20,
                          color: MyTheme.myBlueDark,
                          colors: MyTheme.whiteColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
