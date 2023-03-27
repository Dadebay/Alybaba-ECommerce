import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import '../../home/controllers/color_controller.dart';
import '../controllers/user_profil_controller.dart';
import 'local_widgets.dart';

class UserProfilView extends StatefulWidget {
  const UserProfilView({Key? key}) : super(key: key);

  @override
  State<UserProfilView> createState() => _UserProfilViewState();
}

class _UserProfilViewState extends State<UserProfilView> {
  final ColorController colorController = Get.put(ColorController());

  final UserProfilController userProfilController = Get.put(UserProfilController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('profil'.tr),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colorController.findMainColor.value == 0
              ? kPrimaryColor
              : colorController.findMainColor.value == 1
                  ? kPrimaryColor1
                  : kPrimaryColor2,
        ),
        elevation: 0,
        backgroundColor: colorController.findMainColor.value == 0
            ? kPrimaryColor
            : colorController.findMainColor.value == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
        automaticallyImplyLeading: false,
        titleTextStyle: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 24),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView(
          children: [
            userProfilController.userLogin.value
                ? topPart(userImage: userProfilController.userImage, userMoney: userProfilController.userMoney.value, userName: userProfilController.userName.value)
                : const SizedBox.shrink(),
            thirdPart(userLogin: userProfilController.userLogin.value),
            secondPart(userProfilController.userLogin.value),
            fourthPart(userProfilController.userLogin.value),
          ],
        );
      }),
    );
  }
}
