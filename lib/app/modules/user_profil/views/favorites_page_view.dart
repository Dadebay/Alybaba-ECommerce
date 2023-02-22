import 'package:flutter/material.dart';

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
  const FavoritesPageView({Key? key}) : super(key: key);

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
      appBar:  CustomAppBar(
        backArrow: true,
        actionIcon: false,
        name: 'favorites',
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.data.toString() == '[]') {
            return emptyPageImage(lottie: heartLottie, text1: 'emptyFavT', text2: 'emptyFavS');
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return Obx(() {
            favoritesController.favList2ToShow.clear();
            if (favoritesController.favList2ToShow.isEmpty) {
              for (var element in snapshot.data!) {
                favoritesController.favList2ToShow.add({
                  'id': element.id,
                  'name': element.name,
                  'image': element.image,
                  'price': element.price,
                  'creatAt': element.createdAt,
                });
              }
            }
            return GridView.builder(
              itemCount: favoritesController.favList2ToShow.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  historyOrder: false,
                  discountValue: 0,
                  discountValueType: 0,
                  id: favoritesController.favList2ToShow[index]['id'],
                  createdAt: favoritesController.favList2ToShow[index]['creatAt'],
                  image: "$serverURL/${favoritesController.favList2ToShow[index]['image']}-mini.webp",
                  name: favoritesController.favList2ToShow[index]['name'],
                  price: favoritesController.favList2ToShow[index]['price'],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3.2 / 5),
            );
          });
        },
      ),
    );
  }
}
