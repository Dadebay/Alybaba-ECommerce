import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/category_model.dart';

import '../../modules/category/views/sub_category_view.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.id,
    required this.image,
    required this.name,
    required this.subCategoryList,
    Key? key,
  }) : super(key: key);
  final String name;
  final String image;
  final int id;
  final List<SubCategoryModel> subCategoryList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SubCategoryView(
            subCategoryList: subCategoryList,
            categoryID: id,
            categoryName: name,
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 10, top: 15, right: 10),
            decoration: BoxDecoration(borderRadius: borderRadius40, color: Colors.grey, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 1, blurRadius: 5)]),
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
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(left: 10, top: 15, right: 10),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Colors.black54, borderRadius: borderRadius40),
              alignment: Alignment.center,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
