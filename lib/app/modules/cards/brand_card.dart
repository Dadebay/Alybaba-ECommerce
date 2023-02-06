import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/widgets.dart';
import '../other_pages/show_all_products.dart';

class BrandCard extends StatelessWidget {
  final String name;
  final String image;
  final int id;
  const BrandCard({Key? key, required this.name, required this.id, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShowAllProducts(
              parametrs: {'producer_id': '$id'},
              pageName: name,
            ));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: kPrimaryColor), borderRadius: borderRadius30),
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
                    color: kPrimaryColor,
                    thickness: 1,
                    height: 1,
                  ),
                  Container(
                    width: Get.size.width,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)), color: Colors.white70),
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                        ),
                        Text(
                          "20 Products",
                          style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 16),
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
