import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/data/services/auth_service.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../constants/widgets.dart';

class ReferalPage extends StatelessWidget {
  final UserProfilController userProfilController = Get.put(UserProfilController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backArrow: true,
        actionIcon: true,
        icon: IconButton(
          onPressed: () {
            showSnackBar('referalKod', 'referalDesc', Colors.green);
          },
          icon: const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ),
        name: 'referalKod',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.size.width,
            padding: const EdgeInsets.only(top: 12, left: 10),
            child: Text(
              'referalKod1'.tr,
              style: TextStyle(color: Colors.grey, fontSize: size.width >= 800 ? 30 : 22, fontFamily: gilroySemiBold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 8),
            child: Row(
              children: [
                Text(
                  userProfilController.userReferalCode.toString(),
                  style: TextStyle(fontFamily: gilroySemiBold, fontSize: 24),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: userProfilController.userReferalCode.toString())).then((value) {
                      showSnackBar('copySucces', 'copySuccesSubtitle', Colors.green);
                    });
                  },
                  icon: Icon(
                    Icons.copy,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          dividder(),
          Container(
            width: Get.size.width,
            padding: const EdgeInsets.only(top: 12, left: 10, bottom: 25),
            child: Text(
              'referalKodUsedUser'.tr,
              style: TextStyle(color: Colors.grey, fontSize: size.width >= 800 ? 30 : 22, fontFamily: gilroySemiBold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 00,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    final token = await Auth().getToken();
                  },
                  child: ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.black, fontFamily: gilroyBold),
                    ),
                    title: Text("Referal gelen user name"),
                    subtitle: Text(
                      DateTime.now().toString().substring(0, 11),
                      style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular),
                    ),
                    trailing: Text(
                      "0.2 TMT",
                      style: TextStyle(color: Colors.black, fontFamily: gilroyBold),
                    ),
                  ),
                );
              },
            ),
          ),
          dividder(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'referalKodEarnedMoney'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 22),
                  ),
                ),
                Expanded(
                  child: Text(
                    '0 TMT',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: kPrimaryColor, fontFamily: gilroySemiBold, fontSize: 24),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container dividder() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: const Divider(
        color: Colors.grey,
      ),
    );
  }
}
