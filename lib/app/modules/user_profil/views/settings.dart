// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../constants/buttons/settings_button.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'settings'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SettingButton(
            name: Get.locale!.toLanguageTag() == 'tm'
                ? 'Türkmen dili'
                : Get.locale!.toLanguageTag() == 'ru'
                    ? 'Rus dili'
                    : 'Iňlis dili',
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
                  Get.locale!.toLanguageTag() == 'tr' ? tmIcon : ruIcon,
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
              style: TextStyle(color: kPrimaryColor, fontFamily: gilroyMedium),
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
}
