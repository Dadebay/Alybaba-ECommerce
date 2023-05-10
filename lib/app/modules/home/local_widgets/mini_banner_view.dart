import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/errors/empty_widgets.dart';
import 'package:nabelli_ecommerce/app/constants/errors/error_widgets.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/banner_model.dart';

import '../../../constants/cards/mini_banner_card.dart';

class MiniBannersView extends GetView {
  @override
  const MiniBannersView(this.miniBannerFuture, {Key? key}) : super(key: key);
  final Future<List<BannerModel>> miniBannerFuture;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<BannerModel>>(
      future: miniBannerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return miniBannerLoader();
        } else if (snapshot.hasError) {
          return miniBannerErrorWidget();
        } else if (snapshot.data!.isEmpty) {
          return miniBannerEmptyWidget();
        }
        return CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index, count) {
            return MiniBannerCard(
              model: snapshot.data![index],
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, CarouselPageChangedReason a) {},
            height: size.width >= 800 ? 300 : 170,
            viewportFraction: 0.65,
            autoPlay: true,
            enableInfiniteScroll: true,
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 2000),
          ),
        );
      },
    );
  }
}
