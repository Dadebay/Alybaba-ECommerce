import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/services/auth_service.dart';

dynamic noBannerImage() {
  return const Text('No Image');
}

dynamic spinKit() {
  return CircularProgressIndicator(
    color: kPrimaryColor,
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
            ? SizedBox.shrink()
            : IconButton(
                onPressed: onTap,
                icon: Icon(
                  IconlyLight.arrowRightCircle,
                  color: kPrimaryColor,
                  size: 25,
                ),
              )
      ],
    ),
  );
}

void changeLanguage() {
  final UserProfilController userProfilController = Get.put(UserProfilController());
  dividerr() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Divider(
        color: backgroundColor,
        thickness: 2,
      ),
    );
  }

  button(String name, String icon, Function() onTap) {
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
        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
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
          button("Türkmen", tmIcon, () {
            userProfilController.switchLang('tm');
            Get.back();
          }),
          dividerr(),
          button("Русский", ruIcon, () {
            userProfilController.switchLang('ru');
            Get.back();
          }),
          dividerr(),
          button("English", engIcon, () {
            userProfilController.switchLang('en');
            Get.back();
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
              // await Restart.restartApp();
            },
            child: Container(
              width: Get.size.width,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey[500], borderRadius: borderRadius10),
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
    padding: EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 10),
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
        body = const Text('');
      } else if (mode == LoadStatus.loading) {
        body = CircularProgressIndicator(
          color: kPrimaryColor,
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

// dynamic errorPage({required Function() onTap}) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         'noConnection2'.tr,
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: ElevatedButton(
//           onPressed: onTap,
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(borderRadius: borderRadius10),
//             backgroundColor: kPrimaryColor,
//           ),
//           child: Text(
//             'noConnection3'.tr,
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//         ),
//       )
//     ],
//   );
// }

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
          style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text2.tr,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
        ),
      ],
    ),
  );
}

// dynamic emptryPageText() {
//   return Center(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         'noData1'.tr,
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
//       ),
//     ),
//   );
// }

// Expanded emptyCart() {
//   return Expanded(
//     child: Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset('assets/lottie/emptyCART.json', width: 350, height: 350),
//             Text(
//               'cartEmpty'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
//             ),
//             Text(
//               'cartEmptySubtitle'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

Padding customDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    child: Container(
      width: double.infinity,
      height: 2,
      decoration: BoxDecoration(color: Colors.black12, borderRadius: borderRadius30),
    ),
  );
}

dynamic customDialogToUse({required String title, required String subtitle, required Function() onAgree, required bool changeColor}) {
  return Get.defaultDialog(
    title: title.tr,
    titlePadding: EdgeInsets.only(top: 15),
    radius: 8,
    contentPadding: EdgeInsets.zero,
    titleStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 22),
    content: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            subtitle.tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: onAgree,
                    style: ElevatedButton.styleFrom(backgroundColor: changeColor ? kPrimaryColor : Colors.white, elevation: changeColor ? 1 : 0, padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4), shape: RoundedRectangleBorder(borderRadius: borderRadius5)),
                    child: Text(
                      "yes".tr,
                      style: TextStyle(color: changeColor ? Colors.white : kPrimaryColor, fontFamily: gilroySemiBold, fontSize: 18),
                    )),
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: changeColor ? Colors.white : kPrimaryColor, elevation: changeColor ? 0 : 1, padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4), shape: RoundedRectangleBorder(borderRadius: borderRadius5)),
                    child: Text(
                      "no".tr,
                      style: TextStyle(color: changeColor ? kPrimaryColor : Colors.white, fontFamily: gilroySemiBold, fontSize: 18),
                    )),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
