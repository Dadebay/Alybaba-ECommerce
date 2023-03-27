import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import '../widgets.dart';
import '../../data/models/banner_model.dart';
import '../../data/services/product_service.dart';
import '../../modules/home/views/banner_profil_view.dart';
import '../../modules/other_pages/product_profil_view.dart';
import '../../modules/other_pages/show_all_products.dart';

class MiniBannerCard extends StatelessWidget {
  const MiniBannerCard({
    required this.model,
    Key? key,
  }) : super(key: key);
  final BannerModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (model.pathId == 1) {
          await Get.to(
            () => BannerProfileView(
              description: model.descriptionTM!,
              image: '$serverURL/${model.destination!}-mini.webp',
              pageName: model.titleTM!,
            ),
          );
        } else if (model.pathId == 2) {
          await Get.to(() => ShowAllProducts(pageName: 'banner', filter: false, parametrs: {'main_category_id': '${model.itemId}'}));
        } else if (model.pathId == 3) {
          await ProductsService().getProductByID(model.itemId!).then((value) {
            Get.to(() => ProductProfilView(name: value.name!, id: value.id!, image: '$serverURL/${value.images!.first}-mini.webp', price: value.price!));
          });
        } else {
          showSnackBar('errorTitle', 'error', Colors.red);
        }
      },
      child: Container(
        width: Get.size.width,
        margin: const EdgeInsets.only(left: 14, top: 25),
        decoration: BoxDecoration(
          borderRadius: borderRadius20,
          boxShadow: [
            BoxShadow(
              color: colorController.findMainColor.value == 0
                  ? kPrimaryColor.withOpacity(0.2)
                  : colorController.findMainColor.value == 1
                      ? kPrimaryColor1.withOpacity(0.2)
                      : kPrimaryColor2.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 1,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius20,
          child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: '$serverURL/${model.destination!}-mini.webp',
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
