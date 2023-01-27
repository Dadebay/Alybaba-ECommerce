import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../controllers/auth_controller.dart';
import 'log_in_view.dart';
import 'sign_in_view.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: [
            SizedBox(
              width: Get.size.width,
              height: Get.size.height / 2,
              child: ClipRRect(
                borderRadius: borderRadius30,
                child: Center(
                  child: Container(
                      width: 170,
                      height: 170,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadius30,
                      ),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: borderRadius30,
                        child: Image.asset(
                          logo,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: Get.size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 8),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          indicatorColor: Colors.red,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 22),
                          unselectedLabelStyle: const TextStyle(fontFamily: gilroyRegular),
                          labelColor: Colors.white,
                          indicatorWeight: 4,
                          indicatorPadding: const EdgeInsets.only(top: 45),
                          indicator: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              text: 'signUp'.tr,
                            ),
                            Tab(
                              text: 'login'.tr,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TabBarView(
                        children: [SignInView(), LogInView()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  IconlyBroken.arrowLeftCircle,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
