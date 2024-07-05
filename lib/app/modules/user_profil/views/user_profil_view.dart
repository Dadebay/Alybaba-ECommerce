import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/profile_button.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/modules/auth/views/auth_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/history_order/history_order_status_wait.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/about_us.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/favorites_page_view.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/locations.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/settings.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/terms_and_conditions_page.dart';

import '../../home/controllers/color_controller.dart';
import '../controllers/user_profil_controller.dart';

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
    return Obx(() {
      return ListView(
        children: [
          ProfilButton(
            name: 'orders',
            onTap: () {
              if (userProfilController.userLogin.value) {
                Get.to(
                  () => const OrderStatusWait(
                    whichStatus: 1,
                  ),
                );
              } else {
                showSnackBar('loginError', 'loginError1', Colors.red);
              }
            },
            icon: CupertinoIcons.cube_box,
          ),
          ProfilButton(
            name: 'favorites',
            onTap: () {
              Get.to(() => const FavoritesPageView());
            },
            icon: IconlyBroken.heart,
          ),
          ProfilButton(
            name: 'locations',
            onTap: () {
              Get.to(() => const Locations());
            },
            icon: IconlyBroken.location,
          ),
          divider2(),

          ProfilButton(
            name: 'settings',
            onTap: () {
              Get.to(() => const Settings());
            },
            icon: IconlyBroken.setting,
          ),

          divider2(),
          ProfilButton(
            name: 'aboutUs',
            onTap: () {
              Get.to(() => const AboutUs());
            },
            icon: CupertinoIcons.chat_bubble_2,
          ),
          //
          ProfilButton(
            name: 'terms_and_conditions',
            onTap: () {
              Get.to(() => const TermsAndConditions());
            },
            icon: IconlyBroken.document,
          ),
          ProfilButton(
            icon: userProfilController.userLogin.value ? IconlyBroken.logout : IconlyBroken.login,
            name: userProfilController.userLogin.value ? 'log_out' : 'login',
            onTap: () {
              Get.find<HomeController>().agreeButton.value = false;
              userProfilController.userLogin.value ? logOut() : Get.to(() => AuthView());
            },
          ),
        ],
      );
    });
  }
}
