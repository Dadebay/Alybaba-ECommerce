import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import '../controllers/user_profil_controller.dart';
import 'local_widgets.dart';

class UserProfilView extends StatefulWidget {
  const UserProfilView({Key? key}) : super(key: key);

  @override
  State<UserProfilView> createState() => _UserProfilViewState();
}

class _UserProfilViewState extends State<UserProfilView> {
  final UserProfilController userProfilController = Get.put(UserProfilController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('profil'.tr),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleTextStyle: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 24),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView(
          children: [
            userProfilController.userLogin.value ? topPart(userImage: userProfilController.userImage, userMoney: userProfilController.userMoney.value, userName: userProfilController.userName.value) : const SizedBox.shrink(),
            thirdPart(userLogin: userProfilController.userLogin.value),
            secondPart(userProfilController.userLogin.value),
            fourthPart(userProfilController.userLogin.value),
          ],
        );
      }),
    );
  }
}
