// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/data/models/aboust_us_model.dart';
import 'package:nabelli_ecommerce/app/data/services/abous_us_service.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import 'local_widgets.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(backArrow: true, actionIcon: false, name: 'aboutUs'),
      body: FutureBuilder<AboutUsModel>(
          future: AboutUsService().getAboutUs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
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
          },),
    );
  }
}
