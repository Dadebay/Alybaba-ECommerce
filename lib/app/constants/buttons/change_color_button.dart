import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/modules/auth/views/connection_check_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';

class ChangeColorButton extends StatelessWidget {
  ChangeColorButton({required this.index, Key? key}) : super(key: key);
  final ColorController colorController = Get.put(ColorController());
  final int index;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        divider(),
        ListTile(
          onTap: () async {
            colorController.saveColorInt(index);
            Get.back();
            colorController.returnMainColor();
            await Get.to(() => ConnectionCheckView());
          },
          leading: Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor,
            ),
          ),
          title: Text(
            'appColor2'.tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
