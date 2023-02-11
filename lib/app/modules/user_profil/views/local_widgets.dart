import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/modules/auth/views/auth_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/history_order_status_wait.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/favorites_page_view.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/locations.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/profile_settings.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/referal_code_page.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/terms_and_conditions_page.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/wallet_page.dart';
import 'package:vibration/vibration.dart';

import '../../../constants/constants.dart';
import '../../../constants/buttons/user_profil_icon_button.dart';
import 'about_us.dart';
import 'settings.dart';

Container thirdPart({required String userName, required String userPhoneNumber, required bool userLogin}) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: backgroundColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "profil".tr,
          style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfilIconButton(
              icon: IconlyBroken.profile,
              name: "profil",
              onTap: () {
                if (userLogin) {
                  Get.to(() => ProfileSettings(
                        userName: userName,
                        userPhoneNumebr: userPhoneNumber,
                      ));
                } else {
                  showSnackBar("loginError", 'loginError1', Colors.red);
                  Vibration.vibrate();
                }
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.setting,
              name: "settings",
              onTap: () {
                Get.to(() => Settings());
              },
            ),
            UserProfilIconButton(
              icon: CupertinoIcons.chat_bubble_2,
              name: "aboutUs",
              onTap: () {
                Get.to(() => AboutUs());
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.document,
              name: "terms_and_conditions",
              onTap: () {
                Get.to(() => TermsAndConditions());
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
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: backgroundColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "balance".tr,
          style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfilIconButton(
              icon: IconlyBroken.wallet,
              name: "balance",
              onTap: () {
                if (userLogin) {
                  Get.to(() => WalletPage());
                } else {
                  showSnackBar("loginError", 'loginError1', Colors.red);
                  Vibration.vibrate();
                }
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.ticket,
              name: "referal_Code",
              onTap: () {
                if (userLogin) {
                  Get.to(() => ReferalPage());
                } else {
                  showSnackBar("loginError", 'loginError1', Colors.red);
                  Vibration.vibrate();
                }
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.heart,
              name: "favorites",
              onTap: () {
                Get.to(() => FavoritesPageView());
              },
            ),
            UserProfilIconButton(
              icon: userLogin ? IconlyBroken.logout : IconlyBroken.login,
              name: userLogin ? 'log_out' : "login",
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
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: backgroundColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "orders".tr,
          style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfilIconButton(
              icon: IconlyBroken.timeCircle,
              name: "order_status_wait",
              onTap: () {
                if (userLogin) {
                  Get.to(() => OrderStatusWait(
                        whichStatus: 1,
                      ));
                } else {
                  showSnackBar("loginError", 'loginError1', Colors.red);
                  Vibration.vibrate();
                }
              },
            ),
            UserProfilIconButton(
              icon: CupertinoIcons.cube_box,
              name: "order_status_come",
              onTap: () {
                if (userLogin) {
                  Get.to(() => OrderStatusWait(
                        whichStatus: 2,
                      ));
                } else {
                  showSnackBar("loginError", 'loginError1', Colors.red);
                  Vibration.vibrate();
                }
              },
            ),
            UserProfilIconButton(
              icon: Icons.done_all,
              name: "order_status_submission",
              onTap: () {
                if (userLogin) {
                  Get.to(() => OrderStatusWait(
                        whichStatus: 3,
                      ));
                } else {
                  showSnackBar("loginError", 'loginError1', Colors.red);
                  Vibration.vibrate();
                }
              },
            ),
            UserProfilIconButton(
              icon: IconlyBroken.location,
              name: "locations",
              onTap: () {
                Get.to(() => Locations());
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget topPart({required File userImage, required String userMoney, required String userName, required String userPhoneNumber}) {
  return GestureDetector(
    onTap: () {
      Get.to(() => ProfileSettings(
            userName: userName,
            userPhoneNumebr: userPhoneNumber,
          ));
    },
    child: Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.white,
      padding: EdgeInsets.only(top: 10, left: 10),
      width: Get.size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 3),
              boxShadow: [BoxShadow(color: backgroundColor, blurRadius: 8, spreadRadius: 8)],
            ),
            child: ClipOval(
              child: userImage.path == ''
                  ? Icon(
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
                style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Row(
                  children: [
                    Icon(
                      IconlyBroken.wallet,
                      size: 28,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " - $userMoney",
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
      color: kPrimaryColor,
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
