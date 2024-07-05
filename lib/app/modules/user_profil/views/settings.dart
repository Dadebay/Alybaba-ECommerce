// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/change_color_button.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/change_lang_button.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/buttons/settings_button.dart';
import '../../../constants/constants.dart';
import '../../home/controllers/color_controller.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ColorController colorController = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    final String lang = Get.locale!.toLanguageTag() == 'tm'
        ? 'Türkmen dili'
        : Get.locale!.toLanguageTag() == 'ru'
            ? 'Rus dili'
            : 'Iňlis dili';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'settings'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SettingButton(
            name: lang,
            onTap: () {
              changeLanguage();
            },
            icon: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: ClipRRect(
                borderRadius: borderRadius30,
                child: Image.asset(
                  Get.locale!.toLanguageTag() == 'tm'
                      ? tmIcon
                      : Get.locale!.toLanguageTag() == 'ru'
                          ? ruIcon
                          : engIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SettingButton(
            name: 'versia',
            onTap: () {},
            icon: Text(
              '1.0.0',
              style: TextStyle(
                color: colorController.mainColor,
                fontFamily: gilroyMedium,
              ),
            ),
          ),
          SettingButton(
            name: 'appColor',
            onTap: () {
              changeColor();
            },
            icon: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorController.mainColor,
              ),
            ),
          ),
          SettingButton(
            name: 'share',
            onTap: () {
              Share.share(appShareLink, subject: appName);
            },
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                IconlyBroken.arrowRightCircle,
                color: Colors.black,
              ),
            ),
          ),
          SettingButton(
            name: 'giveLike',
            onTap: () {
              launchURL(appShareLink);
            },
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                IconlyBroken.arrowRightCircle,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  dynamic launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void changeLanguage() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Text(
                    'select_language'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                  ),
                ],
              ),
            ),
            ChangeLangButton(index: 0),
            ChangeLangButton(index: 1),
            ChangeLangButton(index: 2),
          ],
        ),
      ),
    );
  }

  dynamic changeColor() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Text(
                    'appColor1'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                  ),
                ],
              ),
            ),
            ChangeColorButton(
              index: 0,
            ),
            ChangeColorButton(
              index: 1,
            ),
            ChangeColorButton(
              index: 2,
            ),
          ],
        ),
      ),
    );
  }
}
