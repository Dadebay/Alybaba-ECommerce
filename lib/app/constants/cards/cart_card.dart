import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/add_cart_button.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/product_profil_view.dart';

import '../widgets.dart';

class CardCart extends StatelessWidget {
  const CardCart({
    required this.airPlane,
    required this.name,
    required this.price,
    required this.image,
    required this.createdAt,
    required this.id,
    Key? key,
  }) : super(key: key);
  final int id;
  final String name;
  final bool airPlane;
  final String image;
  final String price;
  final String createdAt;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: Get.size.height / 5,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => ProductProfilView(
              name: name,
              image: image,
              id: id,
              price: price,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          elevation: 0.3,
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: borderRadius25),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: borderRadius20,
                child: CachedNetworkImage(
                  fadeInCurve: Curves.ease,
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    width: Get.size.width,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: borderRadius10,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(child: spinKit()),
                  errorWidget: (context, url, error) => Center(
                    child: Text('noImage'.tr),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 10, left: 14, right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.find<CartPageController>().removeCardXButton(id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              CupertinoIcons.xmark_circle,
                              color: colorController.findMainColor.value == 0
                                  ? kPrimaryColor
                                  : colorController.findMainColor.value == 1
                                      ? kPrimaryColor1
                                      : kPrimaryColor2,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 21,
                            fontFamily: gilroyBold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            ' TMT',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontFamily: gilroyBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      createdAt.toString().substring(0, 10),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: gilroyRegular,
                      ),
                    ),
                    AddCartButton(
                      id: id,
                      productProfil: false,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
