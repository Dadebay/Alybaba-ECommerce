// ignore_for_file: file_names, must_be_immutable, always_use_package_imports, avoid_void_async, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/views/cart_view.dart';
import 'package:nabelli_ecommerce/app/modules/category/views/category_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/views/home_view.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/user_profil_view.dart';
import 'package:nabelli_ecommerce/app/modules/videos/views/videos_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with TickerProviderStateMixin {
  TabController? tabController;
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return [
      HomeView(),
      CategoriesView(),
      CartView(), //
      VideosView(), //
      UserProfilView()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      controller: _controller,
      screens: _buildScreens(),
      resizeToAvoidBottomInset: true,
      itemCount: 5,
      screenTransitionAnimation: const ScreenTransitionAnimation(animateTabTransition: true),
      customWidget: CustomNavBarWidget(
        items: [
          PersistentBottomNavBarItem(
            activeColorPrimary: kPrimaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveIcon: const Icon(IconlyBroken.home),
            icon: const Icon(IconlyBold.home),
            title: 'home'.tr,
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: kPrimaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveIcon: const Icon(IconlyBroken.category),
            icon: const Icon(IconlyBold.category),
            title: 'category'.tr,
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: kPrimaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveIcon: const Icon(IconlyBroken.bag2),
            icon: const Icon(IconlyBold.bag2),
            title: 'cart'.tr,
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: kPrimaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveIcon: const Icon(IconlyBroken.discovery),
            icon: const Icon(IconlyBold.discovery),
            title: 'Videos'.tr,
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: kPrimaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveIcon: const Icon(IconlyBroken.profile),
            icon: const Icon(IconlyBold.profile),
            title: 'profil'.tr,
          ),
        ],
        selectedIndex: _controller!.index,
        onItemSelected: (index) {
          setState(() {
            _controller!.index = index;
          });
        },
      ),
    );
  }
}

class CustomNavBarWidget extends StatelessWidget {
  final int? selectedIndex;
  final List<PersistentBottomNavBarItem>? items;
  final ValueChanged<int>? onItemSelected;

  const CustomNavBarWidget({
    this.selectedIndex,
    this.items,
    this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Tooltip(
      message: "${item.title}",
      textStyle: const TextStyle(fontFamily: "Montserrat_Regular", color: Colors.white),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: IconTheme(
                data: IconThemeData(size: 24.0, color: isSelected ? (item.activeColorSecondary ?? item.activeColorPrimary) : item.inactiveColorPrimary ?? item.activeColorPrimary),
                child: isSelected ? item.icon : item.inactiveIcon ?? const SizedBox.shrink(),
              ),
            ),
            Text("${item.title}", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: isSelected ? kPrimaryColor : Colors.grey, fontSize: isSelected ? 12 : 11, fontFamily: gilroyMedium))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      color: Colors.white,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items!.map((item) {
            final int index = items!.indexOf(item);
            return Flexible(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: kPrimaryColor.withOpacity(0.4), padding: EdgeInsets.zero, side: BorderSide.none),
                onPressed: () {
                  onItemSelected!(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
