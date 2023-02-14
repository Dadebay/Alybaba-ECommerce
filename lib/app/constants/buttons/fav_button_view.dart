import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import '../../modules/user_profil/controllers/favorites_page_controller.dart';

class FavButton extends StatefulWidget {
  const FavButton({ required this.whiteColor, required this.id, required this.createdAt, required this.name, required this.price, required this.image,Key? key,}) : super(key: key);
  final bool whiteColor;
  final int id;
  final String name;
  final String price;
  final String createdAt;
  final String image;
  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool value = false;
  final FavoritesPageController favoritesController = Get.put(FavoritesPageController());
  @override
  void initState() {
    super.initState();
    work();
  }

  dynamic work() {
    for (var element in favoritesController.favList) {
      if (element['id'] == widget.id) {
        value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      work();
      return GestureDetector(
        onTap: () {
          value = !value;
          favoritesController.toggleFav(widget.id);
          if (favoritesController.favList2ToShow.isNotEmpty) {
            favoritesController.favList2ToShow.removeWhere((element) => element['id'] == widget.id);
            favoritesController.favList2ToShow.refresh();
          }
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: borderRadius10, color: widget.whiteColor ? Colors.white : Colors.white.withOpacity(0.4), boxShadow: widget.whiteColor ? [] : [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 0.5, blurRadius: 5)]),
          child: Icon(
            value ? IconlyBold.heart : IconlyBroken.heart,
            color: value ? Colors.red : Colors.black,
            size: 26,
          ),
        ),
      );
    });
  }
}
