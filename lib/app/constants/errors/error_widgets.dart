import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      ),
    ),
  );
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
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      ),
    ),
  );
}

dynamic referalPageError() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(noData),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'noData'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: gilroySemiBold),
          ),
        ),
      ],
    ),
  );
}

dynamic locationPageError() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(pinLottie, width: 300, height: 300),
        Text(
          'emptyLocations'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
        ),
      ],
    ),
  );
}

dynamic noBannerImage() {
  return Center(
    child: Text(
      'noImage'.tr,
      style: TextStyle(color: Colors.black, fontFamily: gilroyMedium),
    ),
  );
}
