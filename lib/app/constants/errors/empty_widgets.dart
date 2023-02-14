import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      ),),);
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
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      ),),);
}

dynamic referalPageEmptyData() {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(noData),
      Text(
        'noData1'.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
      )
    ],
  ),);
}

dynamic orderPageEmpty() {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(noData),
      Text(
        'noHistoryOrders'.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
      )
    ],
  ),);
}

dynamic emptyCart() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(emptyCartLottie, fit: BoxFit.cover, animate: true, width: 400, height: 400),
        Text(
          'cartEmpty'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
        ),
        Text(
          'cartEmptySubtitle'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 20),
        ),
        const SizedBox(
          height: 125,
        )
      ],
    ),
  );
}
