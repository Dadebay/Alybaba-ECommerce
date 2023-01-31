import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nabelli_ecommerce/app/data/models/banner_model.dart';

import '../../constants/constants.dart';
import '../../constants/widgets.dart';

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
      onTap: () {
        showSnackBar('Basylanda', "Kategoriya yada Haryda yada Title we desc sahypa gitmeli Dowrandan gelenok son ucin garasdym", Colors.red);
        // if(model)
        // "$serverURL/${snapshot.data![index].destination!}-big.webp",
        // lang == 'tm' ? snapshot.data![index].titleTM! : snapshot.data![index].titleRU!,
        //  lang == 'tm' ? snapshot.data![index].descriptionTM! : snapshot.data![index].descriptionRU!
        // Get.to(() => BannerProfileView(name, image, description));
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
