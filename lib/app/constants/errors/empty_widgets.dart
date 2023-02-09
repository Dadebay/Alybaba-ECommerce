import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

dynamic bannerEmptyWidget() {
  return Container(
      margin: const EdgeInsets.all(8),
      height: 220,
      width: Get.size.width,
      decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.2)),
      child: Center(
          child: Text(
        'noData1'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      )));
}

dynamic miniBannerEmptyWidget() {
  return Container(
      margin: const EdgeInsets.only(top: 14, left: 8, right: 8, bottom: 8),
      height: 140,
      width: Get.size.width,
      decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.2)),
      child: Center(
          child: Text(
        'noData1'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      )));
}
