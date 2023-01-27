import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/modules/cards/product_card.dart';

import '../../../constants/widgets.dart';
import '../controllers/favorites_page_controller.dart';
import '../controllers/user_profil_controller.dart';

class FavoritesPageView extends GetView<FavoritesPageController> {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  final FavoritesPageController favoritesController = Get.put(FavoritesPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        backArrow: true,
        actionIcon: userProfilController.userLogin.value,
        name: 'favorites',
        icon: IconButton(
            onPressed: () {
              customDialogToUse(
                title: "deleteFavProduct",
                subtitle: 'deleteFavProductSubtitle',
                changeColor: false,
                onAgree: () {
                  Get.back();
                  Get.find<FavoritesPageController>().clearFavList();
                  showSnackBar('orderDeleted', 'Halanlarym bosaldyldy', Colors.red);
                },
              );
            },
            icon: Icon(
              IconlyLight.delete,
              color: Colors.white,
            )),
      ),
      body: Obx(() {
        return favoritesController.favList.length == 0
            ? Center(
                child: Text("Empty Page Add Animation"),
              )
            : StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: favoritesController.favList.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    sizeList: [],
                    colorList: [],
                    airPlane: true,
                    id: int.parse(favoritesController.favList[index]['id'].toString()),
                    createdAt: favoritesController.favList[index]['createdAt'].toString(),
                    image: favoritesController.favList[index]['image'],
                    name: favoritesController.favList[index]['name'],
                    price: favoritesController.favList[index]['price'].toString(),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.count(1, index % 2 == 0 ? 1.5 : 1.6),
              );
      }),
    );
  }
}
