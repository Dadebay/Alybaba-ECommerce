import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/data/models/banner_model.dart';
import 'package:nabelli_ecommerce/app/modules/cards/mini_category_card.dart';

import '../../../constants/constants.dart';

class MiniBannersView extends GetView {
  @override
  MiniBannersView(this.miniBannerFuture, {Key? key}) : super(key: key);
  final Future<List<BannerModel>> miniBannerFuture;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
        future: miniBannerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.data!.isEmpty) {
            return Text('Empty');
          }
          return CarouselSlider.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index, count) {
              String lang = Get.locale!.languageCode;
              if (lang == "tr" || lang == 'en') lang = "tm";

              return MiniBannerView(
                id: snapshot.data![index].id!,
                image: "$serverURL/${snapshot.data![index].destination!}-big.webp",
                title: lang == 'tm' ? snapshot.data![index].titleTM! : snapshot.data![index].titleRU!,
                description: lang == 'tm' ? snapshot.data![index].descriptionTM! : snapshot.data![index].descriptionRU!,
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, CarouselPageChangedReason a) {},
              height: 170,
              viewportFraction: 0.65,
              autoPlay: true,
              enableInfiniteScroll: true,
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
            ),
          );
        });
  }
}
