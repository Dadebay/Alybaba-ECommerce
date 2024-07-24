import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import '../../../constants/cards/banner_card.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../data/models/banner_model.dart';
import '../controllers/color_controller.dart';

class Banners extends StatelessWidget {
  final Future<List<BannerModel>> future;
  final bool miniBanner;
  Banners({
    required this.future,
    required this.miniBanner,
    Key? key,
  }) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool sizeValue = size.width >= 800 ? true : false;

    return FutureBuilder<List<BannerModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return miniBanner ? miniBannerLoader() : bannerLoader();
        } else if (snapshot.hasError) {
          return miniBanner ? miniBannerErrorWidget() : bannerErrorWidget();
        } else if (snapshot.data.toString() == '[]') {
          return miniBanner ? miniBannerEmptyWidget() : bannerEmptyWidget();
        }
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index, count) {
                return BannerCard(
                  miniBanner: false,
                  model: snapshot.data![index],
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, CarouselPageChangedReason a) {
                  homeController.bannerDotsIndex.value = index;
                },
                height: sizeValue
                    ? miniBanner
                        ? 300
                        : 420
                    : miniBanner
                        ? 170
                        : 220,
                viewportFraction: miniBanner ? 0.65 : 1.0,
                autoPlay: true,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              ),
            ),
            miniBanner ? SizedBox.shrink() : dots(sizeValue, snapshot),
          ],
        );
      },
    );
  }

  SizedBox dots(bool sizeValue, AsyncSnapshot<List<BannerModel>> snapshot) {
    return SizedBox(
      height: sizeValue ? 40 : 20,
      width: Get.size.width,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              return AnimatedContainer(
                margin: EdgeInsets.symmetric(horizontal: sizeValue ? 8 : 4),
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
                height: homeController.bannerDotsIndex.value == index
                    ? sizeValue
                        ? 22
                        : 16
                    : sizeValue
                        ? 16
                        : 10,
                width: homeController.bannerDotsIndex.value == index
                    ? sizeValue
                        ? 21
                        : 15
                    : sizeValue
                        ? 16
                        : 10,
                decoration: BoxDecoration(
                  color: homeController.bannerDotsIndex.value == index ? Colors.transparent : Colors.grey,
                  shape: BoxShape.circle,
                  border: homeController.bannerDotsIndex.value == index
                      ? Border.all(
                          color: colorController.mainColor,
                          width: 3,
                        )
                      : Border.all(color: Colors.white),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  final ColorController colorController = Get.put(ColorController());
}
