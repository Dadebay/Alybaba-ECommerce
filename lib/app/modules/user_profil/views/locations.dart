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
  Locations({Key? key}) : super(key: key);

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
          icon: userProfilController.userAddressesList.length == 0
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    customDialogToUse(
                      title: "deleteAddress",
                      subtitle: 'deleteAddressTitle',
                      changeColor: false,
                      onAgree: () {
                        Get.back();
                        userProfilController.clearUserAddresses();
                        showSnackBar('orderDeleted', 'ordersDeleted', Colors.red);
                      },
                    );
                  },
                  icon: Icon(
                    IconlyLight.delete,
                    color: Colors.white,
                  )),
          name: 'locations',
        ),
        body: Column(
          children: [
            Expanded(child: Obx(() {
              return userProfilController.userAddressesList.length == 0
                  ? locationPageError()
                  : ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: userProfilController.userAddressesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          tileColor: Colors.white,
                          minLeadingWidth: 15.0,
                          leading: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 14),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          title: Text(
                            userProfilController.userAddressesList[index]['address'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                          ),
                          subtitle: Text(
                            userProfilController.userAddressesList[index]['note'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 18),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return divider();
                      },
                    );
            })),
            ElevatedButton(
                onPressed: () {
                  textEditingControllerNote.clear();
                  textEditingControllerAddress.clear();
                  Get.defaultDialog(
                      title: 'addAddress'.tr,
                      radius: 8.0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      titleStyle: TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                      titlePadding: EdgeInsets.only(top: 15),
                      content: Container(
                        width: Get.size.width / 1.4,
                        child: Column(
                          children: [
                            CustomTextField(labelName: 'address', controller: textEditingControllerAddress, focusNode: titleFocusNode, requestfocusNode: subtitleFocusNode, isNumber: false),
                            CustomTextField(
                              labelName: 'note',
                              controller: textEditingControllerNote,
                              focusNode: subtitleFocusNode,
                              requestfocusNode: titleFocusNode,
                              isNumber: false,
                              maxline: 3,
                            ),
                            SizedBox(
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
                                          shape: RoundedRectangleBorder(
                                            borderRadius: borderRadius10,
                                          ),
                                          backgroundColor: kPrimaryColor),
                                      child: Text(
                                        "add".tr,
                                        style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 18),
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: borderRadius10,
                                          ),
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        "no".tr,
                                        style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.add_circled,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "addAddress".tr,
                      style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18),
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }
}
