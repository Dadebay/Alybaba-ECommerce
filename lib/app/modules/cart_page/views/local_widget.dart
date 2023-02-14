import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/services/auth_service.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/views/order_page.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/terms_and_conditions_page.dart';

dynamic orderDialog(bool airPlane) {
  return Get.defaultDialog(
    title: 'terms_and_conditions'.tr,
    titlePadding: const EdgeInsets.only(top: 15, left: 6, right: 6),
    radius: 8,
    contentPadding: EdgeInsets.zero,
    titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 22),
    content: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Text(
            'terms_and_conditions_to_order'.tr,
            maxLines: 20,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.to(
                      () => OrderPage(
                        airPlane: airPlane,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), shape: const RoundedRectangleBorder(borderRadius: borderRadius5)),
                  child: Text(
                    'skip'.tr,
                    style: const TextStyle(color: kPrimaryColor, fontFamily: gilroySemiBold, fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => TermsAndConditions());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, elevation: 1, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4), shape: const RoundedRectangleBorder(borderRadius: borderRadius5)),
                  child: Text(
                    'read'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

// ignore: long-method
Widget bottomSheetOrderPrice() {
  final CartPageController cartController = Get.put(CartPageController());
  bool airplane = true;
  return Obx(() {
    double sum = 0;
    for (var element in cartController.list) {
      final double a = double.parse(element['price']);
      sum += a * element['quantity'];
      if (element['airplane'] == false) {
        airplane = false;
      }
    }
    return Container(
      height: 50,
      color: Colors.red,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      sum.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: gilroyBold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        ' TMT',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: gilroyBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final String? token = await Auth().getToken();
                if (token == null || token == '') {
                  showSnackBar('loginError', 'loginError1', Colors.red);
                } else {
                  if (cartController.list.isEmpty) {
                    showSnackBar('cartEmpty', 'cartEmptySubtitle', Colors.red);
                  } else {
                    orderDialog( airplane);
                  }
                }
              },
              child: Container(
                color: kPrimaryColor,
                height: Get.size.height,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'orderProducts'.tr,
                      style: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 20),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        IconlyBroken.arrowRightCircle,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

AppBar cartViewAppbar(bool value) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.light),
    centerTitle: true,
    actions: [
      value
          ? IconButton(
              onPressed: () {
                customDialogToUse(
                  title: 'doYouWantToDeleteCart',
                  subtitle: 'doYouWantToDeleteCartSubtitle',
                  onAgree: () {
                    Get.back();

                    showSnackBar('orderDeleted', 'orderDeletedSubtitle', Colors.red);
                    Get.find<CartPageController>().removeAllCartElements();
                  },
                  changeColor: false,
                );
              },
              icon: const Icon(
                IconlyLight.delete,
                color: Colors.white,
              ),
            )
          : const SizedBox.shrink()
    ],
    title: Text('cart'.tr),
    titleTextStyle: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 24),
  );
}

AppBar orderPgaeAppBar() {
  return AppBar(
    backgroundColor: kPrimaryColor,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.light),
    centerTitle: true,
    title: Text(
      'orders'.tr,
      style: const TextStyle(fontFamily: gilroySemiBold, fontSize: 21, color: Colors.white),
    ),
    leading: IconButton(
      icon: const Icon(
        IconlyLight.arrowLeftCircle,
        color: Colors.white,
      ),
      onPressed: () {
        Get.back();
      },
    ),
  );
}
