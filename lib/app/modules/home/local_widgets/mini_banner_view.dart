import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/data/models/banner_model.dart';
import 'package:nabelli_ecommerce/app/modules/cards/mini_category_card.dart';

import '../../../constants/widgets.dart';

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
            return Center(child: spinKit());
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
                model: snapshot.data![index],
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
