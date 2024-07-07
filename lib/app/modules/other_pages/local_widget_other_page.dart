import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/add_cart_button.dart';
import 'package:nabelli_ecommerce/app/constants/errors/error_widgets.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/photo_view_page.dart';

import '../../constants/constants.dart';
import '../../constants/widgets.dart';

Container productProfilNamePricePart({
  required String dostawkaPrice,
  required String name,
  required String price,
  required String barCode,
  required bool kargoIncluded,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 24),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontFamily: gilroyBold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 6, top: 7),
                      child: Text(
                        ' TMT',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontFamily: gilroySemiBold,
                        ),
                      ),
                    ),
                  ],
                ),
                dostawkaPrice != ''
                    ? Row(
                        children: [
                          Text(
                            'forKargo'.tr + ' +' + dostawkaPrice,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: gilroyMedium,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 6, top: 3),
                            child: Text(
                              ' TMT',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: gilroyMedium,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ],
        ),
        Text(
          'Barcode : ' + barCode,
          style: const TextStyle(color: Colors.grey, fontFamily: gilroyMedium, fontSize: 18),
        ),
        kargoIncluded
            ? Text(
                'kargoIncluded'.tr,
                style: const TextStyle(color: Colors.red, fontFamily: gilroySemiBold, fontSize: 19),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}

Container productProfildescriptionPart({
  required String brand,
  required String category,
  required String viewCount,
  required String createdAt,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(15),
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'data'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 21),
          ),
        ),
        twoText(name1: "${"brandPP".tr} : ", name2: brand),
        twoText(name1: "${"category".tr} :", name2: category),
        twoText(name1: 'data3'.tr, name2: viewCount),
        twoText(name1: 'createdAt'.tr, name2: createdAt),
        const SizedBox(
          height: 30,
        ),
        divider(),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'description'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 21),
          ),
        ),
        Text(
          description,
          style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.black54),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

Widget twoText({required String name1, required String name2}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name1,
          style: const TextStyle(color: Colors.black54, fontFamily: gilroyMedium, fontSize: 18),
        ),
        Text(
          name2,
          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
        ),
      ],
    ),
  );
}

Container imagesView(List<dynamic> images) {
  return Container(
    color: Colors.white,
    height: Get.size.height / 2.5,
    margin: const EdgeInsets.only(bottom: 15),
    child: images.isEmpty
        ? noBannerImage()
        : CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, count) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => PhotoViewPageMoreImage(
                      images: images,
                    ),
                  );
                },
                child: CachedNetworkImage(
                  fadeInCurve: Curves.ease,
                  imageUrl: "$serverURL/${images[index]['destination']}-big.webp",
                  imageBuilder: (context, imageProvider) => Container(
                    width: Get.size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => spinKit(),
                  errorWidget: (context, url, error) => noBannerImage(),
                ),
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, CarouselPageChangedReason a) {},
              viewportFraction: 1.0,
              autoPlay: true,
              height: Get.size.height,
              aspectRatio: 4 / 2,
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
            ),
          ),
  );
}

Container addCartButtonPart({required String price, required int id}) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'price'.tr,
              style: TextStyle(
                color: colorController.mainColor,
                fontFamily: gilroyMedium,
                fontSize: 16,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: gilroyBold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4, right: 6),
                  child: Text(
                    ' TMT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: gilroyBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Expanded(
          flex: 1,
          child: SizedBox.shrink(),
        ),
        Expanded(
          flex: 4,
          child: AddCartButton(
            id: id,
            productProfil: true,
          ),
        ),
      ],
    ),
  );
}
