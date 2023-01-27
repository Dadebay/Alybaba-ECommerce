import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import '../../../constants/constants.dart';
import '../../../constants/phone_number.dart';
import '../../../constants/widgets.dart';
import '../../../data/services/sign_in_service.dart';
import '../../buttons/agree_button_view.dart';
import 'otp_check.dart';

class LogInView extends GetView {
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  final login = GlobalKey<FormState>();
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: login,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
              child: Text(
                'signInDialog'.tr,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: PhoneNumber(
                mineFocus: phoneNumberFocusNode,
                controller: phoneNumberController,
                requestFocus: phoneNumberFocusNode,
                style: false,
              ),
            ),
            Center(child: AgreeButton(onTap: () {
              homeController.agreeButton.value = !homeController.agreeButton.value;
              if (login.currentState!.validate()) {
                if (homeController.agreeButton.value == true) {
                  SignInService().login(phone: phoneNumberController.text).then((value) {
                    if (value == 200) {
                      Get.to(() => OtpCheck(
                            phoneNumber: phoneNumberController.text,
                            register: false,
                            userName: '',
                          ));
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
              } else {
                showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                homeController.agreeButton.value = !homeController.agreeButton.value;
              }
            })),
          ],
        ),
      ),
    );
  }
}
