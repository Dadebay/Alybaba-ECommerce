import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import '../../constants/widgets.dart';

class MiniBannerView extends StatelessWidget {
  const MiniBannerView({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  final int id;
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => BannerProfileView(title, image, description));
      },
      child: Container(
        width: Get.size.width,
        margin: const EdgeInsets.only(left: 14, top: 25),
        decoration: BoxDecoration(borderRadius: borderRadius20, color: Colors.grey.withOpacity(0.1)),
        child: ClipRRect(
          borderRadius: borderRadius20,
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
    );
  }
}
