// // ignore_for_file: file_names, must_be_immutable, always_use_package_imports, avoid_void_async, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../cart_page/views/cart_view.dart';
import '../../category/views/category_view.dart';
import '../../user_profil/views/user_profil_view.dart';
import '../controllers/color_controller.dart';
import 'home_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final ColorController colorController = Get.put(ColorController());

  List page = [const HomeView(), const CategoriesView(), const CartView(), const UserProfilView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: colorController.findMainColor.value == 0
            ? kPrimaryColor
            : colorController.findMainColor.value == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
        useLegacyColorScheme: true,
        selectedLabelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 12),
        currentIndex: selectedIndex,
        onTap: (index) async {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.home),
            activeIcon: const Icon(IconlyBold.home),
            label: 'home'.tr,
            tooltip: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.category),
            activeIcon: const Icon(IconlyBold.category),
            label: 'category'.tr,
            tooltip: 'category'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.bag2),
            activeIcon: const Icon(IconlyBold.bag2),
            label: 'cart'.tr,
            tooltip: 'cart'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              IconlyLight.profile,
            ),
            activeIcon: const Icon(IconlyBold.profile),
            label: 'profil'.tr,
            tooltip: 'profil'.tr,
          ),
        ],
      ),
      body: Center(
        child: page[selectedIndex],
      ),
    );
  }
}
