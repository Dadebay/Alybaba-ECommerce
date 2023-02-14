// ignore_for_file: file_names, deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/agree_button_view.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/constants.dart';
import '../../../constants/text_fields/custom_text_field.dart';
import '../../../constants/text_fields/phone_number.dart';
import '../controllers/user_profil_controller.dart';
import 'local_widgets.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({
    required this.userName,
    required this.userPhoneNumebr,
    Key? key,
  }) : super(key: key);
  final String userName;
  final String userPhoneNumebr;
  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  File? selectedImage;
  final storage = GetStorage();

  dynamic changeData() async {
    userNameController.text = widget.userName;
    phoneController.text = widget.userPhoneNumebr;
    if (await storage.read('userImage') == null) {
      selectedImage = null;
    } else {
      if (userProfilController.userImage.toString() == '') {
        selectedImage = null;
      } else {
        final imageTemporary = File(userProfilController.userImage.path);
        selectedImage = imageTemporary;
        setState(() {});
      }
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        selectedImage = imageTemporary;
        userProfilController.userImage = imageTemporary;
        storage.write('userImage', selectedImage);
      });
    } catch (error) {
      showSnackBar('noConnection3', '$error', Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    changeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(backArrow: true, actionIcon: false, name: 'profil'),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Center(
              child: selectedImage != null
                  ? GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.white30, blurRadius: 15.0, offset: Offset(1.0, 1.0), spreadRadius: 5.0)],
                          ),
                          child: ClipOval(child: Material(elevation: 3, child: Image.file(selectedImage!, fit: BoxFit.cover))),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await Permission.camera.request();
                        await Permission.photos.request();
                        await pickImage();
                      },
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: DottedBorder(
                            borderType: BorderType.Oval,
                            radius: const Radius.circular(12),
                            padding: const EdgeInsets.all(6),
                            strokeWidth: 2,
                            color: kPrimaryColor,
                            child: const Center(
                              child: Icon(
                                Icons.add_circle_outline_sharp,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            textPartUserProfil('userName'),
            CustomTextField(
              labelName: '',
              controller: userNameController,
              borderRadius: true,
              focusNode: userNameFocusNode,
              requestfocusNode: userNameFocusNode,
              isNumber: false,
              disabled: false,
            ),
            textPartUserProfil('phoneNumber'),
            PhoneNumber(
              mineFocus: phoneFocusNode,
              controller: phoneController,
              requestFocus: userNameFocusNode,
              style: false,
              disabled: false,
            ),
            const SizedBox(
              height: 25,
            ),
            AgreeButton(
              onTap: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
