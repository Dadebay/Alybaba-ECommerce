import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../constants/constants.dart';
import '../../../constants/custom_app_bar.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../constants/text_fields/custom_text_field.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final UserProfilController userProfilController = Get.put(UserProfilController());
  @override
  void initState() {
    super.initState();
    userProfilController.returnUserAddresses();
  }

  FocusNode titleFocusNode = FocusNode();
  FocusNode subtitleFocusNode = FocusNode();
  TextEditingController textEditingControllerAddress = TextEditingController();
  TextEditingController textEditingControllerNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        backArrow: true,
        actionIcon: userProfilController.userLogin.value,
        icon: userProfilController.userAddressesList.isEmpty
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: () {
                  customDialogToUse(
                    title: 'deleteAddress',
                    subtitle: 'deleteAddressTitle',
                    changeColor: false,
                    onAgree: () {
                      Get.back();
                      userProfilController.clearUserAddresses();
                      showSnackBar('orderDeleted', 'ordersDeleted', Colors.red);
                    },
                  );
                },
                icon: const Icon(
                  IconlyLight.delete,
                  color: Colors.white,
                ),
              ),
        name: 'locations',
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return userProfilController.userAddressesList.isEmpty
                  ? locationPageError()
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: userProfilController.userAddressesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          tileColor: Colors.white,
                          minLeadingWidth: 15.0,
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color:  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 14),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          title: Text(
                            userProfilController.userAddressesList[index]['address'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                          ),
                          subtitle: Text(
                            userProfilController.userAddressesList[index]['note'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 18),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return divider();
                      },
                    );
            }),
          ),
          ElevatedButton(
            onPressed: () {
              textEditingControllerNote.clear();
              textEditingControllerAddress.clear();
              Get.defaultDialog(
                title: 'addAddress'.tr,
                radius: 8.0,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                titlePadding: const EdgeInsets.only(top: 15),
                content: SizedBox(
                  width: Get.size.width / 1.4,
                  child: Column(
                    children: [
                      CustomTextField(
                        labelName: 'address',
                        controller: textEditingControllerAddress,
                        focusNode: titleFocusNode,
                        requestfocusNode: subtitleFocusNode,
                        isNumber: false,
                        unFocus: false,
                      ),
                      CustomTextField(
                        labelName: 'note',
                        controller: textEditingControllerNote,
                        focusNode: subtitleFocusNode,
                        requestfocusNode: titleFocusNode,
                        isNumber: false,
                        maxline: 3,
                        unFocus: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                userProfilController.addAddressesToList(address: textEditingControllerAddress.text, note: textEditingControllerNote.text);
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: borderRadius10,
                                ),
                                backgroundColor:  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
                              ),
                              child: Text(
                                'add'.tr,
                                style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: borderRadius10,
                                ),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'no'.tr,
                                style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
              shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.add_circled,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'addAddress'.tr,
                  style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
