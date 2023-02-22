// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import '../../modules/home/controllers/color_controller.dart';

class AgreeButton extends StatelessWidget {
  final Function() onTap;

  AgreeButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  var homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: animatedContaner());
  }

  final ColorController colorController = Get.put(ColorController());

  Widget animatedContaner() {
    return Obx(() {
      return AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: borderRadius20,
          color: colorController.findMainColor.value == 0
              ? kPrimaryColor
              : colorController.findMainColor.value == 1
                  ? kPrimaryColor1
                  : kPrimaryColor2,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: homeController.agreeButton.value ? 0 : 10),
        width: homeController.agreeButton.value ? 60 : Get.size.width,
        duration: const Duration(milliseconds: 1000),
        child: homeController.agreeButton.value
            ? const Center(
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                'agree'.tr,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 22),
              ),
      );
    });
  }
}
