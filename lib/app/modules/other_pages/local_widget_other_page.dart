import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/widgets.dart';

Container productProfilNamePricePart({
  required String name,
  required String price,
  required String barCode,
  required bool kargoIncluded,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 24),
              ),
            ),
            Row(
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontFamily: gilroyBold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 6, top: 7),
                  child: Text(
                    ' TMT',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: gilroySemiBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          barCode,
          style: const TextStyle(color: Colors.grey, fontFamily: gilroyMedium, fontSize: 18),
        ),
        kargoIncluded
            ? Text(
                'kargoIncluded'.tr,
                style: const TextStyle(color: Colors.red, fontFamily: gilroySemiBold, fontSize: 19),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}

Container productProfildescriptionPart({
  required String brand,
  required String category,
  required String viewCount,
  required String createdAt,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(15),
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'data'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 21),
          ),
        ),
        twoText(name1: "${"brandPP".tr} : ", name2: brand),
        twoText(name1: "${"category".tr} :", name2: category),
        twoText(name1: 'data3'.tr, name2: viewCount),
        twoText(name1: 'createdAt'.tr, name2: createdAt),
        const SizedBox(
          height: 30,
        ),
        customDivider(),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'description'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 21),
          ),
        ),
        Text(
          description,
          style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.black54),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

Widget twoText({required String name1, required String name2}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name1,
          style: const TextStyle(color: Colors.black54, fontFamily: gilroyMedium, fontSize: 18),
        ),
        Text(
          name2,
          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
        ),
      ],
    ),
  );
}
