// ignore_for_file: always_put_required_named_parameters_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/add_cart_button.dart';

import '../widgets.dart';
import '../buttons/fav_button_view.dart';
import '../../modules/other_pages/product_profil_view.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String createdAt;
  final int id;
  final int discountValueType;
  final int discountValue;
  final bool historyOrder;

  const ProductCard({
    required this.image,
    required this.id,
    required this.discountValue,
    required this.discountValueType,
    required this.historyOrder,
    required this.createdAt,
    required this.name,
    required this.price,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width >= 800 ? 280 : 180,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius15,
      ),
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: Colors.white,
          shadowColor: colorController.findMainColor.value == 0
              ? kPrimaryColor
              : colorController.findMainColor.value == 1
                  ? kPrimaryColor1
                  : kPrimaryColor2,
          padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 5),
          shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
        ),
        onPressed: () {
          if (historyOrder) {
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductProfilView(
                    name: name,
                    image: image,
                    id: id,
                    price: price,
                  );
                },
              ),
            );
          }
        },
        child: Column(
          children: [
            imagePart(size, createdAt),
            namePart1(),
            historyOrder
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                    child: AddCartButton(
                      id: id,
                      productProfil: false,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Expanded imagePart(Size size, String createdAt) {
    return Expanded(
      flex: 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: borderRadius20,
              child: CachedNetworkImage(
                fadeInCurve: Curves.ease,
                imageUrl: image,
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
                placeholder: (context, url) => Center(child: spinKit()),
                errorWidget: (context, url, error) => Center(
                  child: Text('noImage'.tr),
                ),
              ),
            ),
          ),
          discountValueType == 1
              ? Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: const BoxDecoration(color: Colors.red, borderRadius: borderRadius5),
                    child: Text(
                      '-$discountValue%',
                      style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          historyOrder
              ? const SizedBox.shrink()
              : Positioned(
                  top: 8,
                  right: 6,
                  child: FavButton(
                    whiteColor: true,
                    createdAt: createdAt,
                    id: id,
                    price: price,
                    name: name,
                    image: image,
                  ),
                )
        ],
      ),
    );
  }

  Widget namePart1() {
    double pricee = double.parse(price.toString());
    if (discountValueType == 2) {
      pricee -= discountValue.toDouble();
    } else if (discountValueType == 1) {
      double procent = discountValue / 100;
      procent *= pricee;
      pricee -= procent;
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5, left: 4, bottom: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          discountValueType == 1
              ? discountPriceWidget(pricee)
              : discountValueType == 2
                  ? discountPriceWidget(pricee)
                  : normalPrice(pricee),
          Text(
            name == '' ? 'Haryt ady' : name,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Row discountPriceWidget(double pricee) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          price.substring(0, price.length - 1).toString(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            height: 2,
            decoration: TextDecoration.lineThrough,
            fontFamily: gilroyMedium,
            decorationColor: Colors.grey.shade400,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                pricee.toString(),
                style: TextStyle(
                  color: colorController.findMainColor.value == 0
                      ? kPrimaryColor
                      : colorController.findMainColor.value == 1
                          ? kPrimaryColor1
                          : kPrimaryColor2,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: gilroySemiBold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, right: 6),
                  child: Text(
                    ' TMT',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorController.findMainColor.value == 0
                          ? kPrimaryColor
                          : colorController.findMainColor.value == 1
                              ? kPrimaryColor1
                              : kPrimaryColor2,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: gilroySemiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row normalPrice(double pricee) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          pricee.toString(),
          style: TextStyle(
            color: colorController.findMainColor.value == 0
                ? kPrimaryColor
                : colorController.findMainColor.value == 1
                    ? kPrimaryColor1
                    : kPrimaryColor2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: gilroySemiBold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 6),
          child: Text(
            ' TMT',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorController.findMainColor.value == 0
                  ? kPrimaryColor
                  : colorController.findMainColor.value == 1
                      ? kPrimaryColor1
                      : kPrimaryColor2,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: gilroySemiBold,
            ),
          ),
        ),
      ],
    );
  }
}
