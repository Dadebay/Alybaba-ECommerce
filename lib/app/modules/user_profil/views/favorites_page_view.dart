import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/cards/product_card.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/create_order.dart';
import '../controllers/favorites_page_controller.dart';
import '../controllers/user_profil_controller.dart';

class FavoritesPageView extends StatefulWidget {
  @override
  State<FavoritesPageView> createState() => _FavoritesPageViewState();
}

class _FavoritesPageViewState extends State<FavoritesPageView> {
  final FavoritesPageController favoritesController = Get.put(FavoritesPageController());

  final UserProfilController userProfilController = Get.put(UserProfilController());
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    products = CreateOrderService().getCartItems(false);

    super.initState();
  }

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
                  favoritesController.clearFavList();
                  favoritesController.favList2ToShow.clear();
                  showSnackBar('orderDeleted', 'Halanlarym bosaldyldy', Colors.red);
                },
              );
            },
            icon: Icon(
              IconlyLight.delete,
              color: Colors.white,
            )),
      ),
      body: FutureBuilder<List<ProductModel>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.data.toString() == '[]') {
              return emptyPageImage(lottie: heartLottie, text1: 'emptyFavT', text2: 'emptyFavS');
            } else if (snapshot.hasError) {
              return Text("Error");
            }

            return Obx(() {
              favoritesController.favList2ToShow.clear();
              if (favoritesController.favList2ToShow.isEmpty) {
                snapshot.data!.forEach((element) {
                  favoritesController.favList2ToShow.add({
                    'id': element.id,
                    'name': element.name,
                    'image': element.image,
                    'price': element.price,
                    'creatAt': element.createdAt,
                  });
                });
              }
              return GridView.builder(
                itemCount: favoritesController.favList2ToShow.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    id: favoritesController.favList2ToShow[index]['id'],
                    createdAt: favoritesController.favList2ToShow[index]['creatAt'],
                    image: "$serverURL/${favoritesController.favList2ToShow[index]['image']}-big.webp",
                    name: favoritesController.favList2ToShow[index]['name'],
                    price: favoritesController.favList2ToShow[index]['price'],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3.2 / 5),
              );
            });
          }),
    );
  }
}
