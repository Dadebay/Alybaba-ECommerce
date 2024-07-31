// // ignore_for_file: file_names, must_be_immutable, always_use_package_imports, avoid_void_async, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/services/auth_service.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/views/order_page.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../constants/constants.dart';
import '../controllers/color_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final ColorController colorController = Get.put(ColorController());
  final CartPageController cartController = Get.put(CartPageController());
  final UserProfilController userProfilController = Get.put(UserProfilController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavBar(),
      bottomSheet: selectedIndex == 2 ? bottomSheetOrderPrice() : SizedBox.shrink(),
      appBar: selectedIndex == 0
          ? homeViewAppBar()
          : CustomAppBar(
              backArrow: false,
              actionIcon: true,
              icon: iconsAppBar[selectedIndex],
              name: '${pageTitle[selectedIndex]}'.tr,
            ),
      body: Center(
        child: page[selectedIndex],
      ),
    );
  }

  Widget bottomNavBar() {
    return Obx(() {
      print(cartController.list.length);
      return BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 26,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: colorController.mainColor,
        useLegacyColorScheme: true,
        selectedLabelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 12),
        currentIndex: selectedIndex,
        onTap: (index) async {
          setState(() {
            selectedIndex = index;
          });
        },
        items: List.generate(
          4,
          (index) => BottomNavigationBarItem(
            icon: cartController.list.length > 0
                ? index == 2
                    ? iconWithBadge(index, false)
                    : Icon(
                        icons[index],
                      )
                : Icon(icons[index]),
            activeIcon: cartController.list.length > 0
                ? index == 2
                    ? iconWithBadge(index, true)
                    : Icon(
                        iconsBold[index],
                      )
                : Icon(iconsBold[index]),
            label: '${pageTitle[index]}'.tr,
            tooltip: '${pageTitle[index]}'.tr,
          ),
        ),
      );
    });
  }

  Stack iconWithBadge(int index, bool active) {
    return Stack(
      children: [
        Icon(
          active ? iconsBold[index] : icons[index],
        ),
        Positioned(
          right: 0,
          top: -4,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              cartController.list.length.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: gilroyBold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheetOrderPrice() {
    final CartPageController cartController = Get.put(CartPageController());
    final ColorController colorController = Get.put(ColorController());

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
      String lang = Get.locale!.languageCode;
      if (lang == 'tr' || lang == 'en') {
        lang = 'tm';
      }
      return Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: lang == 'tm' ? 1 : 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
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
            Expanded(
              flex: lang == 'tm' ? 1 : 3,
              child: TextButton.icon(
                onPressed: () async {
                  final String? token = await Auth().getToken();
                  if (token == null || token == '') {
                    showSnackBar('loginError', 'loginError1', Colors.red);
                  } else {
                    if (cartController.list.isEmpty) {
                      showSnackBar('cartEmpty', 'cartEmptySubtitle', Colors.red);
                    } else {
                      await Get.to(
                        () => OrderPage(
                          airPlane: airplane,
                        ),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(colorController.mainColor),
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'orderProducts'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 20),
                  ),
                ),
                iconAlignment: IconAlignment.end,
                icon: Icon(
                  IconlyBroken.arrowRightCircle,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
