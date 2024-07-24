// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';

class ProfilButton extends StatelessWidget {
  final String name;
  final Function() onTap;
  final IconData icon;
  ProfilButton({
    required this.name,
    required this.onTap,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final ColorController colorController = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 23,
      title: Text(
        name.tr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.black),
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: colorController.mainColor, borderRadius: borderRadius15),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      trailing: Icon(
        IconlyLight.arrowRightCircle,
        color: colorController.mainColor,
      ),
    );
  }
}
