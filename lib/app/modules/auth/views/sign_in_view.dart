import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import '../../../constants/constants.dart';
import '../../../constants/text_fields/custom_text_field.dart';
import '../../../constants/text_fields/phone_number.dart';
import '../../../constants/widgets.dart';
import '../../../data/services/sign_in_service.dart';
import '../../../constants/buttons/agree_button_view.dart';
import 'otp_check.dart';

class SignInView extends GetView {
  TextEditingController fullNameController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  TextEditingController idController = TextEditingController();
  FocusNode idFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();

  TextEditingController referalCodeController = TextEditingController();
  FocusNode referalCodeFocusNode = FocusNode();
  final _signUp = GlobalKey<FormState>();
  final HomeController homeController = Get.put(HomeController());

  SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: _signUp,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 14, top: 12),
                    child: Text(
                      'signInDialog'.tr,
                      style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                    ),
                  ),
                  CustomTextField(
                    labelName: 'signIn1',
                    controller: fullNameController,
                    focusNode: fullNameFocusNode,
                    requestfocusNode: idFocusNode,
                    borderRadius: true,
                    isNumber: false,
                    unFocus: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                      labelName: 'signIn2',
                      controller: idController,
                      focusNode: idFocusNode,
                      requestfocusNode: phoneNumberFocusNode,
                      borderRadius: true,
                      isNumber: false,
                      unFocus: false,
                    ),
                  ),
                  PhoneNumber(
                    mineFocus: phoneNumberFocusNode,
                    controller: phoneNumberController,
                    requestFocus: referalCodeFocusNode,
                    style: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                labelName: 'referalKod',
                controller: referalCodeController,
                focusNode: referalCodeFocusNode,
                requestfocusNode: fullNameFocusNode,
                borderRadius: true,
                isNumber: false,
                unFocus: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: AgreeButton(
                onTap: () {
                  homeController.agreeButton.value = !homeController.agreeButton.value;

                  if (_signUp.currentState!.validate()) {
                    SignInService().sendCode(phone: phoneNumberController.text).then((value) {
                      if (value == 200) {
                        Get.to(
                          () => OtpCheck(
                            phoneNumber: phoneNumberController.text,
                            register: true,
                            referalKod: referalCodeController.text,
                            userName: '${fullNameController.text} ${idController.text} ',
                          ),
                        );
                      } else if (value == 409) {
                        showSnackBar('noConnection3', 'alreadyExist', Colors.red);
                      } else {
                        showSnackBar('noConnection3', 'errorData', Colors.red);
                      }
                    });
                  } else {
                    showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                  }
                  homeController.agreeButton.value = !homeController.agreeButton.value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
