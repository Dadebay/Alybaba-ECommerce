import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/auth/views/connection_check_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restart_app/restart_app.dart';

import '../data/services/auth_service.dart';
import '../modules/other_pages/show_all_products.dart';

final ColorController colorController = Get.put(ColorController());

dynamic noBannerImage() {
  return Text('noImage'.tr);
}

dynamic spinKit() {
  return Lottie.asset(loading1Lottie, animate: true, width: 150, height: 150);
}

Widget searchField(TextEditingController controller, BuildContext context) {
  final ColorController colorController = Get.put(ColorController());
  return Padding(
    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
    child: TextFormField(
      style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      cursorColor: Colors.black,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'errorEmpty'.tr;
        }
        return null;
      },
      onEditingComplete: () async {
        await Get.to(() => ShowAllProducts(pageName: 'search', filter: false, parametrs: {'search': controller.text}));
        controller.clear();
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontFamily: gilroyMedium),
        hintText: 'search'.tr,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Icon(
            IconlyLight.search,
            color: Colors.black,
          ),
        ),
        fillColor: backgroundColor,
        filled: true,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: gilroyMedium),
        contentPadding: const EdgeInsets.only(left: 25, top: 14, bottom: 14, right: 10),
        border: const OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(
            color: colorController.findMainColor.value == 0
                ? kPrimaryColor
                : colorController.findMainColor.value == 1
                    ? kPrimaryColor1
                    : kPrimaryColor2,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(
            color: colorController.findMainColor.value == 0
                ? kPrimaryColor
                : colorController.findMainColor.value == 1
                    ? kPrimaryColor1
                    : kPrimaryColor2,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    ),
  );
}

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  if (SnackbarController.isSnackbarBeingShown) {
    SnackbarController.cancelAllSnackbars();
  }
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontFamily: gilroySemiBold, fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontFamily: gilroyRegular, fontSize: 16, color: Colors.white),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    borderRadius: 20.0,
    animationDuration: const Duration(milliseconds: 500),
    margin: const EdgeInsets.all(8),
  );
}

Container divider() {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: Divider(
      color: kPrimaryColor.withOpacity(0.4),
      thickness: 2,
    ),
  );
}

Padding namePart({required String text, required bool removeIcon, required Function() onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text.tr, style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 22)),
        removeIcon
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: onTap,
                icon: Icon(
                  IconlyLight.arrowRightCircle,
                  color: colorController.findMainColor.value == 0
                      ? kPrimaryColor
                      : colorController.findMainColor.value == 1
                          ? kPrimaryColor1
                          : kPrimaryColor2,
                  size: 25,
                ),
              )
      ],
    ),
  );
}

void changeLanguage() {
  final userProfilController = UserProfilController();
  Container dividerr() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: const Divider(
        color: backgroundColor,
        thickness: 2,
      ),
    );
  }

  ListTile button(String name, String icon, Function() onTap) {
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          icon,
        ),
        backgroundColor: Colors.black,
        radius: 20,
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
      ),
    );
  }

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
                )
              ],
            ),
          ),
          dividerr(),
          button('Türkmen', tmIcon, () async {
            userProfilController.switchLang('tm');
            Get.back();
            await Restart.restartApp();
          }),
          dividerr(),
          button('Русский', ruIcon, () async {
            userProfilController.switchLang('ru');
            Get.back();
            await Restart.restartApp();
          }),
          dividerr(),
          button('English', engIcon, () async {
            userProfilController.switchLang('en');
            Get.back();
            await Restart.restartApp();
          }),
        ],
      ),
    ),
  );
}

void logOut() {
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  'log_out'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.white),
                )
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: Text(
              'log_out_title'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontFamily: gilroyMedium,
                fontSize: 18,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Get.find<UserProfilController>().userLogin.value = false;
              await Auth().logout();
              Get.back();
              await Restart.restartApp();
            },
            child: Container(
              width: Get.size.width,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: borderRadius10),
              child: Text(
                'yes'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Get.back();
            },
            child: Container(
              width: Get.size.width,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.red, borderRadius: borderRadius10),
              child: Text(
                'no'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Padding listViewName(String text, bool icon, Size size, Function() onTap) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text.tr,
          style: TextStyle(color: Colors.black, fontSize: size.width >= 800 ? 30 : 22, fontFamily: gilroyBold),
        ),
        icon
            ? GestureDetector(
                onTap: onTap,
                child: Icon(
                  IconlyBroken.arrowRightCircle,
                  color: Colors.black,
                  size: size.width >= 800 ? 35 : 25,
                ),
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}

CustomFooter footer() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text('Garaşyň...');
      } else if (mode == LoadStatus.loading) {
        body = CircularProgressIndicator(
          color: colorController.findMainColor.value == 0
              ? kPrimaryColor
              : colorController.findMainColor.value == 1
                  ? kPrimaryColor1
                  : kPrimaryColor2,
        );
      } else if (mode == LoadStatus.failed) {
        body = const Text('Load Failed!Click retry!');
      } else if (mode == LoadStatus.canLoading) {
        body = const Text('');
      } else {
        body = const Text('No more Data');
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

Padding textpart(String name, bool value) {
  return Padding(
    padding: EdgeInsets.only(left: 8, top: value ? 15 : 30),
    child: Text(
      name.tr,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 18, color: Colors.black, fontFamily: gilroyMedium),
    ),
  );
}

void defaultBottomSheet({required String name, required Widget child}) {
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  name.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Center(
            child: child,
          )
        ],
      ),
    ),
  );
}

Widget dividerr() {
  return Container(
    color: Colors.grey[300],
    width: double.infinity,
    height: 1,
  );
}

dynamic emptyPageImage({
  required String lottie,
  required String text1,
  required String text2,
}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(lottie, width: 350, height: 350),
        Text(
          text1.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text2.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
        ),
      ],
    ),
  );
}

Padding customDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    child: Container(
      width: double.infinity,
      height: 2,
      decoration: const BoxDecoration(color: Colors.black12, borderRadius: borderRadius30),
    ),
  );
}

dynamic customDialogToUse({required String title, required String subtitle, required Function() onAgree, required bool changeColor}) {
  return Get.defaultDialog(
    title: title.tr,
    titlePadding: const EdgeInsets.only(top: 15),
    radius: 8,
    contentPadding: EdgeInsets.zero,
    titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 22),
    content: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            subtitle.tr,
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
                  onPressed: onAgree,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: changeColor
                        ? colorController.findMainColor.value == 0
                            ? kPrimaryColor
                            : colorController.findMainColor.value == 1
                                ? kPrimaryColor1
                                : kPrimaryColor2
                        : Colors.white,
                    elevation: changeColor ? 1 : 0,
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
                  ),
                  child: Text(
                    'yes'.tr,
                    style: TextStyle(
                      color: changeColor
                          ? Colors.white
                          : colorController.findMainColor.value == 0
                              ? kPrimaryColor
                              : colorController.findMainColor.value == 1
                                  ? kPrimaryColor1
                                  : kPrimaryColor2,
                      fontFamily: gilroySemiBold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: changeColor
                        ? Colors.white
                        : colorController.findMainColor.value == 0
                            ? kPrimaryColor
                            : colorController.findMainColor.value == 1
                                ? kPrimaryColor1
                                : kPrimaryColor2,
                    elevation: changeColor ? 0 : 1,
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
                  ),
                  child: Text(
                    'no'.tr,
                    style: TextStyle(
                      color: changeColor
                          ? colorController.findMainColor.value == 0
                              ? kPrimaryColor
                              : colorController.findMainColor.value == 1
                                  ? kPrimaryColor1
                                  : kPrimaryColor2
                          : Colors.white,
                      fontFamily: gilroySemiBold,
                      fontSize: 18,
                    ),
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

void changeColor(BuildContext context) {
  final ColorController homeController = Get.put(ColorController());
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
                )
              ],
            ),
          ),
          divider(),
          ListTile(
            onTap: () async {
              homeController.saveColorInt(0);
              Get.back();
              homeController.returnMainColor();
              await Get.to(() => ConnectionCheckView());
            },
            leading: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
            ),
            title: Text(
              'appColor2'.tr,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          divider(),
          ListTile(
            onTap: () async {
              homeController.saveColorInt(1);
              Get.back();
              homeController.returnMainColor();
              await Get.to(() => ConnectionCheckView());
            },
            leading: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor1,
              ),
            ),
            title: Text(
              'appColor3'.tr,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          divider(),
          ListTile(
            onTap: () async {
              homeController.saveColorInt(2);
              Get.back();
              homeController.returnMainColor();
              await Get.to(() => ConnectionCheckView());
            },
            leading: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor2,
              ),
            ),
            title: Text(
              'appColor4'.tr,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}
