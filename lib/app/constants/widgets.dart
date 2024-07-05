import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/aboust_us_model.dart';
import 'package:nabelli_ecommerce/app/data/services/abous_us_service.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../data/services/auth_service.dart';
import '../modules/other_pages/show_all_products.dart';

final ColorController colorController = Get.put(ColorController());
final CartPageController cartController = Get.put(CartPageController());

Widget searchField(TextEditingController controller) {
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
        await Get.to(() => ShowAllProducts(pageName: 'search', parametrs: {'search': controller.text}));
        controller.clear();
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
            color: colorController.mainColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(
            color: colorController.mainColor,
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
    snackPosition: SnackPosition.TOP,
    backgroundColor: color,
    borderRadius: 20.0,
    animationDuration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(8),
  );
}

Container divider() {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: Divider(
      color: colorController.mainColor.withOpacity(0.4),
      thickness: 2,
    ),
  );
}

Padding divider2() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Divider(
      thickness: 1,
      color: colorController.mainColor.withOpacity(0.2),
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
                ),
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
            : const SizedBox.shrink(),
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
          color: colorController.mainColor,
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
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Center(
            child: child,
          ),
        ],
      ),
    ),
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
                    backgroundColor: changeColor ? colorController.mainColor : Colors.white,
                    elevation: changeColor ? 1 : 0,
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
                  ),
                  child: Text(
                    'yes'.tr,
                    style: TextStyle(
                      color: changeColor ? Colors.white : colorController.mainColor,
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
                    backgroundColor: changeColor ? Colors.white : colorController.mainColor,
                    elevation: changeColor ? 0 : 1,
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
                  ),
                  child: Text(
                    'no'.tr,
                    style: TextStyle(
                      color: changeColor ? colorController.mainColor : Colors.white,
                      fontFamily: gilroySemiBold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Bottom Nav bar page widgets
Widget CallButton() {
  return IconButton(
    onPressed: () {
      defaultBottomSheet(
        child: FutureBuilder<AboutUsModel>(
          future: AboutUsService().getAboutUs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return spinKit();
            } else if (snapshot.data == null) {
              return Text('error'.tr);
            } else if (snapshot.hasError) {
              return Text('error'.tr);
            }
            return Wrap(
              children: [
                ListTile(
                  onTap: () {
                    launchUrlString('tel://8-${snapshot.data!.phone1!}');
                  },
                  title: Text(
                    '+993-${snapshot.data!.phone1!}',
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                  ),
                  trailing: const Icon(
                    IconlyBroken.arrowRightCircle,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {
                    launchUrlString('tel://8-${snapshot.data!.phone2!}');
                  },
                  title: Text(
                    '+993-${snapshot.data!.phone2!}',
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                  ),
                  trailing: const Icon(
                    IconlyBroken.arrowRightCircle,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          },
        ),
        name: 'callNumber'.tr,
      );
    },
    icon: const Icon(
      IconlyBroken.call,
      color: Colors.white,
    ),
  );
}

Widget DeleteButton() {
  return IconButton(
    onPressed: () {
      customDialogToUse(
        title: 'doYouWantToDeleteCart',
        subtitle: 'doYouWantToDeleteCartSubtitle',
        onAgree: () {
          Get.back();
          showSnackBar('orderDeleted', 'orderDeletedSubtitle', Colors.red);
          cartController.removeAllCartElements();
        },
        changeColor: false,
      );
    },
    icon: const Icon(
      IconlyLight.delete,
      color: Colors.white,
    ),
  );
}

AppBar homeViewAppBar() {
  final TextEditingController textEditingController = TextEditingController();

  return AppBar(
    elevation: 0,
    toolbarHeight: 80,
    backgroundColor: colorController.mainColor,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: colorController.mainColor,
    ),
    leadingWidth: 0.0,
    titleSpacing: 0.0,
    shadowColor: colorController.mainColor,
    foregroundColor: colorController.mainColor,
    scrolledUnderElevation: 0.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
    title: Container(
      width: Get.size.width,
      child: searchField(textEditingController),
    ),
  );
}
