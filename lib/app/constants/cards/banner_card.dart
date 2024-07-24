import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/errors/error_widgets.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/banner_model.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/product_profil_view.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';

import '../../data/services/product_service.dart';
import '../../modules/home/views/banner_profil_view.dart';
import '../constants.dart';

class BannerCard extends StatelessWidget {
  final ColorController colorController = Get.put(ColorController());
  final bool miniBanner;
  final BannerModel model;
  BannerCard({
    required this.model,
    required this.miniBanner,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
          await Get.to(() => ShowAllProducts(pageName: 'banner', parametrs: {'main_category_id': '${model.itemId}'}));
        } else if (model.pathId == 3) {
          await ProductsService().getProductByID(model.itemId!).then((value) {
            Get.to(() => ProductProfilView(name: value.name!, id: value.id!, image: '$serverURL/${value.images!.first}-mini.webp', price: value.price!));
          });
        }
      },
      child: Container(
        margin: miniBanner ? EdgeInsets.only(left: 14, top: 25) : EdgeInsets.all(8),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: borderRadius20,
          boxShadow: [
            BoxShadow(
              color: colorController.mainColor.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius20,
          child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: '$serverURL/${model.destination!}-mini.webp',
            imageBuilder: (context, imageProvider) => Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: borderRadius20,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => spinKit(),
            errorWidget: (context, url, error) => noBannerImage(),
          ),
        ),
      ),
    );
  }
}
