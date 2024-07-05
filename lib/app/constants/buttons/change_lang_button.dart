import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

class ChangeLangButton extends StatelessWidget {
  ChangeLangButton({required this.index, Key? key}) : super(key: key);
  final int index;
  List icon = [tmIcon, ruIcon, engIcon];
  List lang = ['Türkmen dili', 'Rus dili', 'Iňlis dili'];
  List langText = ['tm', 'ru', 'en'];
  final UserProfilController userProfilController = Get.put(UserProfilController());
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: const Divider(
            color: backgroundColor,
            thickness: 2,
          ),
        ),
        ListTile(
          dense: true,
          minVerticalPadding: 0,
          onTap: () {
            userProfilController.switchLang(langText[index]);
            Get.back();
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              icon[index],
            ),
            backgroundColor: Colors.black,
            radius: 20,
          ),
          title: Text(
            lang[index],
            style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
