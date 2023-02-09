import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';

import '../constants.dart';

dynamic bannerLoader() {
  return Container(margin: const EdgeInsets.all(8), height: 220, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.2)), child: Center(child: spinKit()));
}

dynamic miniBannerLoader() {
  return Container(margin: const EdgeInsets.all(8), height: 140, width: Get.size.width, decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.grey.withOpacity(0.2)), child: Center(child: spinKit()));
}
