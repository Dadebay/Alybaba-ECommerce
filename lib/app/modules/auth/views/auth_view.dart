import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/agree_button_view.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/text_fields/phone_number.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/services/sign_in_service.dart';
import 'package:nabelli_ecommerce/app/modules/auth/views/otp_check.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import '../../../constants/constants.dart';
import '../../home/controllers/color_controller.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);
  final ColorController colorController = Get.put(ColorController());
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final login = GlobalKey<FormState>();
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.mainColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: ''),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          logoPart(),
          textPart(),
        ],
      ),
    );
  }

  Container textPart() {
    return Container(
      height: Get.size.height / 2.0,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Form(
        key: login,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'login'.tr,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 24),
            ),
            Text(
              'signInDialog'.tr,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: PhoneNumber(
                mineFocus: phoneNumberFocusNode,
                controller: phoneNumberController,
                requestFocus: phoneNumberFocusNode,
                unFocus: true,
                style: false,
              ),
            ),
            Center(
              child: AgreeButton(
                onTap: () {
                  if (login.currentState!.validate()) {
                    homeController.agreeButton.value = !homeController.agreeButton.value;

                    if (homeController.agreeButton.value) {
                      loginUser();
                    }
                  } else {
                    showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                    homeController.agreeButton.value = !homeController.agreeButton.value;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic singUpUser() {
    SignInService().sendCode(phone: phoneNumberController.text).then((value) {
      if (value == 200) {
        Get.to(
          () => OtpCheck(
            phoneNumber: phoneNumberController.text,
            register: true,
            referalKod: '',
            userName: 'Taze ulanyjy  ${phoneNumberController.text}',
          ),
        );
        homeController.agreeButton.value = !homeController.agreeButton.value;
      } else if (value == 409) {
        showSnackBar('noConnection3', 'alreadyExist', Colors.red);
        homeController.agreeButton.value = !homeController.agreeButton.value;
      } else {
        showSnackBar('noConnection3', 'errorData', Colors.red);
        homeController.agreeButton.value = !homeController.agreeButton.value;
      }
    });
  }

  dynamic loginUser() {
    SignInService().login(phone: phoneNumberController.text).then((value) {
      if (value == 200) {
        Get.to(() => OtpCheck(phoneNumber: phoneNumberController.text.toString(), register: false, userName: '', referalKod: ''));
        homeController.agreeButton.value = !homeController.agreeButton.value;
      } else if (value == 409) {
        showSnackBar('noConnection3', 'alreadyExist', Colors.red);
        homeController.agreeButton.value = !homeController.agreeButton.value;
      } else if (value == 422) {
        singUpUser();
      } else {
        showSnackBar('noConnection3', 'errorData', Colors.red);
        homeController.agreeButton.value = !homeController.agreeButton.value;
      }
    });
  }

  Widget logoPart() {
    return Container(
      height: Get.size.height / 2.2,
      child: Center(
        child: ClipRRect(
          borderRadius: borderRadius30,
          child: Image.asset(
            logo,
            fit: BoxFit.cover,
            width: 170,
            height: 170,
          ),
        ),
      ),
    );
  }
}
