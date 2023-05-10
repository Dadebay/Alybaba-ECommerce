import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import '../../../constants/cards/banner_card.dart';
import '../../../constants/constants.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../data/models/banner_model.dart';
import '../controllers/color_controller.dart';

class Banners extends StatelessWidget {
  final Future<List<BannerModel>> future;
  Banners({
    required this.future,
    Key? key,
  }) : super(key: key);
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<BannerModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return bannerLoader();
        } else if (snapshot.hasError) {
          return bannerErrorWidget();
        } else if (snapshot.data.toString() == '[]') {
          return bannerEmptyWidget();
        }
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index, count) {
                return BannerCard(
                  model: snapshot.data![index],
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, CarouselPageChangedReason a) {
                  controller.bannerDotsIndex.value = index;
                },
                height: size.width >= 800 ? 420 : 220,
                viewportFraction: 1.0,
                autoPlay: true,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              ),
            ),
            dots(snapshot, size)
          ],
        );
      },
    );
  }

  final ColorController colorController = Get.put(ColorController());

  SizedBox dots(AsyncSnapshot<List<BannerModel>> snapshot, Size size) {
    return SizedBox(
      height: size.width >= 800 ? 40 : 20,
      width: Get.size.width,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              return AnimatedContainer(
                margin: EdgeInsets.symmetric(horizontal: size.width >= 800 ? 8 : 4),
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
                height: controller.bannerDotsIndex.value == index
                    ? size.width >= 800
                        ? 22
                        : 16
                    : size.width >= 800
                        ? 16
                        : 10,
                width: controller.bannerDotsIndex.value == index
                    ? size.width >= 800
                        ? 21
                        : 15
                    : size.width >= 800
                        ? 16
                        : 10,
                decoration: BoxDecoration(
                  color: controller.bannerDotsIndex.value == index ? Colors.transparent : Colors.grey,
                  shape: BoxShape.circle,
                  border: controller.bannerDotsIndex.value == index
                      ? Border.all(
                          color: colorController.findMainColor.value == 0
                              ? kPrimaryColor
                              : colorController.findMainColor.value == 1
                                  ? kPrimaryColor1
                                  : kPrimaryColor2,
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
}
