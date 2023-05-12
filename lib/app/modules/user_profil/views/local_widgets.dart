import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/modules/auth/views/auth_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/history_order/history_order_status_wait.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/favorites_page_view.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/locations.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/profile_settings.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/referal_code_page.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/terms_and_conditions_page.dart';

import '../../../constants/constants.dart';
import '../../../constants/buttons/user_profil_icon_button.dart';
import 'about_us.dart';
import 'settings.dart';

Container thirdPart({required bool userLogin}) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: backgroundColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'profil'.tr,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfilIconButton(
              icon: IconlyBroken.profile,
              name: 'profil',
              onTap: () {
                if (userLogin) {
                  Get.to(
                    () => const ProfileSettings(),
                  );
                } else {
                  showSnackBar('loginError', 'loginError1', Colors.red);
                }
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.setting,
              name: 'settings',
              onTap: () {
                Get.to(() => const Settings());
              },
            ),
            UserProfilIconButton(
              icon: CupertinoIcons.chat_bubble_2,
              name: 'aboutUs',
              onTap: () {
                Get.to(() => const AboutUs());
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Container fourthPart(bool userLogin) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: backgroundColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'more'.tr,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfilIconButton(
              icon: IconlyBroken.ticket,
              name: 'referal_Code',
              onTap: () {
                if (userLogin) {
                  Get.to(() => ReferalPage());
                } else {
                  showSnackBar('loginError', 'loginError1', Colors.red);
                }
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.document,
              name: 'terms_and_conditions',
              onTap: () {
                Get.to(() => const TermsAndConditions());
              },
            ),
            UserProfilIconButton(
              icon: userLogin ? IconlyBroken.logout : IconlyBroken.login,
              name: userLogin ? 'log_out' : 'login',
              onTap: () {
                Get.find<HomeController>().agreeButton.value = false;
                userLogin ? logOut() : Get.to(() => AuthView());
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Container secondPart(bool userLogin) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: backgroundColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'orders'.tr,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfilIconButton(
              icon: CupertinoIcons.cube_box,
              name: 'orders',
              onTap: () {
                if (userLogin) {
                  Get.to(
                    () => const OrderStatusWait(
                      whichStatus: 1,
                    ),
                  );
                } else {
                  showSnackBar('loginError', 'loginError1', Colors.red);
                }
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.heart,
              name: 'favorites',
              onTap: () {
                Get.to(() => const FavoritesPageView());
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.location,
              name: 'locations',
              onTap: () {
                Get.to(() => const Locations());
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget topPart({required File userImage, required String userMoney, required String userName}) {
  return GestureDetector(
    onTap: () {
      Get.to(
        () => const ProfileSettings(),
      );
    },
    child: Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10, left: 10),
      width: Get.size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 3),
              boxShadow: const [BoxShadow(color: backgroundColor, blurRadius: 8, spreadRadius: 8)],
            ),
            child: ClipOval(
              child: userImage.path == ''
                  ? const Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    )
                  : Image.file(
                      userImage,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Row(
                  children: [
                    const Icon(
                      IconlyBroken.wallet,
                      size: 28,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ' - $userMoney',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontFamily: gilroySemiBold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            ' TMT',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: gilroySemiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

ListTile simpleWidget({
  required IconData icon,
  required String name,
}) {
  return ListTile(
    dense: true,
    onTap: () async {},
    minLeadingWidth: 10,
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
    shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
    leading: Icon(
      icon,
      color: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
    ),
    title: Text(
      name,
      textAlign: TextAlign.start,
      style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.black),
    ),
  );
}

Padding textPartUserProfil(String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, top: 30),
    child: Text(
      name.tr,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 18, color: Colors.black, fontFamily: gilroyMedium),
    ),
  );
}
