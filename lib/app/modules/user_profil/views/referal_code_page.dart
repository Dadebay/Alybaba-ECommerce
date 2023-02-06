import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/data/services/referal_service.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/referal_model.dart';

class ReferalPage extends StatelessWidget {
  final UserProfilController userProfilController = Get.put(UserProfilController());
  double sum = 0.0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(),
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
          _userOwnReferel(),
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
            child: FutureBuilder<List<ReferalModel>>(
                future: ReferalService().getReferrals(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: spinKit());
                  } else if (snapshot.hasError) {
                    return Text("Error");
                  } else if (snapshot.data.toString() == '[]') {
                    return Text('Empty');
                  }
                  sum = 0;
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      sum += double.parse(snapshot.data![index].sum.toString());
                      return ListTile(
                        minLeadingWidth: 10,
                        leading: Text(
                          '${index + 1}.',
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyBold),
                        ),
                        title: Text(
                          snapshot.data![index].fullName!,
                          style: TextStyle(color: Colors.black, fontFamily: gilroyRegular),
                        ),
                        subtitle: Text(
                          snapshot.data![index].date!.substring(0, 10),
                          style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular),
                        ),
                        trailing: Text(
                          "${snapshot.data![index].sum} TMT",
                          style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 18),
                        ),
                      );
                    },
                  );
                }),
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
                    '$sum TMT',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: kPrimaryColor, fontFamily: gilroySemiBold, fontSize: 22),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _userOwnReferel() {
    return Padding(
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
    );
  }

  CustomAppBar _appbar() {
    return CustomAppBar(
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
