import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/cards/cart_card.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/create_order.dart';
import 'local_widget.dart';

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartPageController cartController = Get.put(CartPageController());
  final UserProfilController userProfilController = Get.put(UserProfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: cartViewAppbar(userProfilController.userLogin.value),
      bottomSheet: bottomSheetOrderPrice(context),
      body: Stack(
        children: [
          Positioned.fill(
              child: FutureBuilder<List<ProductModel>>(
                  future: CreateOrderService().getCartItems(true),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: spinKit());
                    } else if (snapshot.data.toString() == '[]') {
                      return Center(child: Lottie.asset(emptyCartLottie));
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    }
                    return Obx(() {
                      cartController.cartListToCompare.clear();
                      snapshot.data!.forEach((element) {
                        cartController.cartListToCompare.add({
                          'id': element.id,
                          'name': element.name,
                          'image': element.image,
                          'price': element.price,
                          'creatAt': element.createdAt,
                          "airPlane": element.airplane!,
                        });
                      });
                      return ListView.builder(
                        itemCount: cartController.cartListToCompare.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return CardCart(
                            airPlane: cartController.cartListToCompare[index]['airPlane']!,
                            name: cartController.cartListToCompare[index]['name']!,
                            createdAt: cartController.cartListToCompare[index]['id']!,
                            id: cartController.cartListToCompare[index]['airPlane']!,
                            price: cartController.cartListToCompare[index]['price in']!,
                            image: cartController.cartListToCompare[index]['image']!,
                          );
                        },
                      );
                    });
                  })),
          Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Obx(() {
                double sum = 0;
                cartController.list.forEach((element) {
                  double a = double.parse(element['price']);
                  sum += a;
                });
                return sum > 50
                    ? SizedBox.shrink()
                    : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(14),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.2), borderRadius: borderRadius5),
                        child: Text(
                          "minSumCount".tr,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontFamily: gilroySemiBold, fontSize: 16),
                        ),
                      );
              })),
        ],
      ),
    );
  }
}