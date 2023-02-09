import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

dynamic bannerErrorWidget() {
  return Container(
      margin: const EdgeInsets.all(8),
      height: 220,
      width: Get.size.width,
      decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.2)),
      child: Center(
          child: Text(
        'noData'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      )));
}

dynamic miniBannerErrorWidget() {
  return Container(
      margin: const EdgeInsets.all(8),
      height: 140,
      width: Get.size.width,
      decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.2)),
      child: Center(
          child: Text(
        'noData'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      )));
}