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
        String lang = await Get.locale!.languageCode.toString();
        if (model.pathId == 1) {
          Get.to(() => BannerProfileView(
                description: lang == 'tm' ? model.descriptionTM! : model.descriptionRU!,
                image: "$serverURL/${model.destination!}-big.webp",
                pageName: lang == 'tm' ? model.titleTM! : model.titleRU!,
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
        width: Get.size.width,
        margin: const EdgeInsets.only(left: 14, top: 25),
        decoration: BoxDecoration(borderRadius: borderRadius20, color: Colors.grey.withOpacity(0.1)),
        child: ClipRRect(
          borderRadius: borderRadius20,
          child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: "$serverURL/${model.destination!}-big.webp",
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
