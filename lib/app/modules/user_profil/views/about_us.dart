// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/aboust_us_model.dart';
import 'package:nabelli_ecommerce/app/data/services/abous_us_service.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';

import '../../../constants/constants.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final ColorController colorController = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'aboutUs'),
      body: FutureBuilder<AboutUsModel>(
        future: AboutUsService().getAboutUs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return spinKit();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.data == null) {
            return const Text('Empty');
          }
          return Container(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(
                    'contactInformation'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                  ),
                ),
                simpleWidget(
                  icon: IconlyBold.message,
                  name: snapshot.data!.email!,
                ),
                simpleWidget(
                  icon: IconlyBold.location,
                  name: snapshot.data!.address!,
                ),
                simpleWidget(
                  icon: IconlyBold.call,
                  name: '+993${snapshot.data!.phone1!}',
                ),
                simpleWidget(
                  icon: IconlyBold.call,
                  name: '+993${snapshot.data!.phone2!}',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ListTile simpleWidget({
    required IconData icon,
    required String name,
  }) {
    return ListTile(
      dense: true,
      onTap: () async {},
      minLeadingWidth: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
      leading: Icon(
        icon,
        color: colorController.mainColor,
      ),
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.black),
      ),
    );
  }
}
