// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import '../../../constants/text_fields/custom_text_field.dart';
import '../../../constants/widgets.dart';
import '../../../data/services/sign_in_service.dart';
import '../../../constants/buttons/agree_button_view.dart';
import '../../user_profil/controllers/user_profil_controller.dart';
import 'connection_check_view.dart';

class OtpCheck extends StatelessWidget {
  final String phoneNumber;
  final String? userName;
  final String? referalKod;
  final bool register;
  FocusNode otpFocusNode = FocusNode();
  final otpCheck = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  OtpCheck({
    required this.phoneNumber,
    required this.register,
    this.referalKod,
    this.userName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar:  CustomAppBar(backArrow: true, actionIcon: false, name: 'otp'),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'otpSubtitle'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'waitForSms'.tr,
                style: const TextStyle(color: Colors.red, fontSize: 20, fontFamily: gilroyMedium),
              ),
            ),
            Form(key: otpCheck, child: CustomTextField(labelName: 'otp', controller: otpController, focusNode: otpFocusNode, requestfocusNode: otpFocusNode, borderRadius: true, isNumber: true,unFocus: true,)),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: AgreeButton(
                onTap: () {
                  if (otpCheck.currentState!.validate()) {
                    Get.find<HomeController>().agreeButton.value = !Get.find<HomeController>().agreeButton.value;
                    if (register) {
                      SignInService().register(otp: otpController.text, phoneNumber: phoneNumber, fullName: userName!, referalKod: referalKod!).then((value) {
                        if (value == 200) {
                          Get.find<UserProfilController>().userLogin.value = true;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const ConnectionCheckView(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          showSnackBar('otpErrorTitle', 'otpErrorSubtitle', Colors.red);
                        }
                        Get.find<HomeController>().agreeButton.value = !Get.find<HomeController>().agreeButton.value;
                      });
                    } else {
                      SignInService().otpCheck(otp: otpController.text, phoneNumber: phoneNumber).then((value) {
                        if (value == 200) {
                          Get.find<UserProfilController>().userLogin.value = true;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const ConnectionCheckView(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          showSnackBar('otpErrorTitle', 'otpErrorSubtitle', Colors.red);
                        }
                        Get.find<HomeController>().agreeButton.value = !Get.find<HomeController>().agreeButton.value;
                      });
                    }
                  } else {
                    showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
