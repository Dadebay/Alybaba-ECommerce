import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/aboust_us_model.dart';
import '../../../data/services/abous_us_service.dart';
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
        leading: IconButton(
          onPressed: () {
            defaultBottomSheet(
              child: FutureBuilder<AboutUsModel>(
                future: AboutUsService().getAboutUs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(child: spinKit()),
                    );
                  } else if (snapshot.data == null) {
                    return const Text('Empty');
                  } else if (snapshot.hasError) {
                    return const Text('Error');
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
                      )
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
        ),
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
