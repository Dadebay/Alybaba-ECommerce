import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/data/models/banner_model.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/product_profil_view.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';

import '../constants.dart';
import '../widgets.dart';
import '../../data/services/product_service.dart';
import '../../modules/home/views/banner_profil_view.dart';

class BannerCard extends StatelessWidget {
  final BannerModel model;
  const BannerCard({
    required this.model,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        if (model.pathId == 1) {
          Get.to(() => BannerProfileView(
                description: model.descriptionTM!,
                image: "$serverURL/${model.destination!}-big.webp",
                pageName: model.titleTM!,
              ));
        } else if (model.pathId == 2) {
          Get.to(() => ShowAllProducts(pageName: 'banner', filter: false, parametrs: {'main_category_id': '${model.itemId}'}));
        } else if (model.pathId == 3) {
          ProductsService().getProductByID(model.itemId!).then((value) {
            Get.to(() => ProductProfilView(name: value.name!, id: value.id!, image: "$serverURL/${value.images![0]}-big.webp", price: value.price!));
          });
        } else {
          showSnackBar('errorTitle', 'error', Colors.red);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: size.width,
        decoration: const BoxDecoration(
          borderRadius: borderRadius10,
        ),
        child: ClipRRect(
          borderRadius: borderRadius10,
          child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: "$serverURL/${model.destination!}-big.webp",
            imageBuilder: (context, imageProvider) => Container(
              width: size.width,
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
