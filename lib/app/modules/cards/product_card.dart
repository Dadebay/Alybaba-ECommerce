// ignore_for_file: always_put_required_named_parameters_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/buttons/add_cart_button.dart';

import '../../constants/widgets.dart';
import '../buttons/fav_button_view.dart';
import '../other_pages/product_profil_view.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String createdAt;
  final int id;

  const ProductCard({
    required this.image,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius15,
      ),
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: Colors.white,
          shadowColor: kPrimaryColor,
          padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 5),
          shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
        ),
        onPressed: () {
          Get.to(() => ProductProfilView(
                name: name,
                image: image,
                id: id,
                price: price,
              ));
        },
        child: Column(
          children: [
            imagePart(size, createdAt),
            namePart1(),
            Padding(
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
                  child: Text('No Image'),
                ),
              ),
            ),
          ),
          Positioned(
              top: 8,
              right: 6,
              child: FavButton(
                whiteColor: true,
                createdAt: createdAt,
                id: id,
                price: price,
                name: name,
                image: image,
              ))
        ],
      ),
    );
  }

  Widget namePart1() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5, left: 4, bottom: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                price == '' ? "5" : price.substring(0, price.length - 1),
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: gilroySemiBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 6),
                child: Text(
                  ' TMT',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: gilroySemiBold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            name == '' ? 'Haryt ady' : name,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
