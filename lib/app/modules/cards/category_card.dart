import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';

import '../../data/services/product_service.dart';
import '../other_pages/show_all_products.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    required this.id,
    required this.image,
    required this.name,
  });
  final String name;
  final String image;
  final int id;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Get.to(() => ShowAllProducts(
              pageName: name,
              getData: ProductsService().getProducts(parametrs: {'main_category_id': '$id'}),
            ));
      },
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, top: 15, right: 10),
              decoration: BoxDecoration(borderRadius: borderRadius40, color: Colors.red, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 1, blurRadius: 5)]),
              child: ClipRRect(
                borderRadius: borderRadius40,
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
              )),
          Positioned.fill(
              child: Container(
            margin: EdgeInsets.only(left: 10, top: 15, right: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.black54, borderRadius: borderRadius40),
            alignment: Alignment.center,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 40),
            ),
          )),
        ],
      ),
    );
  }
}
