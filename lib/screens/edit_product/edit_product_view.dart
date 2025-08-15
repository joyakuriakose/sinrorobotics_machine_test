import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../components/app_buttons.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import 'edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  const EditProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyUtils.hideKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: MyTheme.appColor),
            onPressed: () => Get.back(),
          ),
          title: const Text('Edit Product',
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.titleController,
                      decoration: const InputDecoration(labelText: "Title"),
                    ),
                    TextField(
                      controller: controller.priceController,
                      decoration: const InputDecoration(labelText: "Price"),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(labelText: "Description"),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    MAButton(
                      buttonPress: () async {
                        controller.updateProduct;
                      },
                      text: 'Save Changes',
                      height: 40,
                      width: 200,
                      clipBehavior: 5,
                      radius: 5,
                      fontSize: 16,
                      color: MyTheme.myBlueDark,
                      colors: MyTheme.whiteColor,
                    ),
                  ],
                ),
              ),
              if (controller.isScreenProgress.value)
                Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
