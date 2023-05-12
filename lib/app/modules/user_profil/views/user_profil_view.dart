import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/profile_settings.dart';
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
                ? GestureDetector(
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
                              child: userProfilController.userImage.path == ''
                                  ? const Icon(
                                      Icons.info_outline,
                                      color: Colors.black,
                                    )
                                  : Image.file(
                                      userProfilController.userImage,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userProfilController.userName.value,
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
                                          ' - ${userProfilController.userMoney.value}',
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
                  )
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
