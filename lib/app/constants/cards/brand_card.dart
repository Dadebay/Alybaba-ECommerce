import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../widgets.dart';
import '../../modules/other_pages/show_all_products.dart';

class BrandCard extends StatelessWidget {
  final String name;
  final String productCount;
  final String image;
  final int id;
  const BrandCard({
    required this.name,
    required this.id,
    required this.image,
    required this.productCount, Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ShowAllProducts(
            parametrs: {'producer_id': '$id'},
            pageName: name,
            filter: false,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius30, boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1), blurRadius: 2, spreadRadius: 2)]),
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 80,
              top: 20,
              right: 20,
              left: 20,
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius10,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(child: spinKit()),
                errorWidget: (context, url, error) => Center(
                  child: noBannerImage(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                   Divider(
                    color:  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: Get.size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)), color: Colors.white70),
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                        ),
                        Text(
                          productCount + 'product'.tr,
                          style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
