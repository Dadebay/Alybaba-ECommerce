import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/cards/cart_card.dart';
import 'package:nabelli_ecommerce/app/constants/errors/empty_widgets.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../constants/errors/error_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/create_order.dart';
import 'local_widget.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

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
      bottomSheet: bottomSheetOrderPrice(),
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder<List<ProductModel>>(
              future: CreateOrderService().getCartItems(true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.data.toString() == '[]') {
                  return emptyCart();
                } else if (snapshot.hasError) {
                  return referalPageError();
                }
                return Obx(() {
                  return ListView.builder(
                    itemCount: cartController.cartListToCompare.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: cartController.cartListToCompare.length - 1 == index ? 80 : 0),
                        child: CardCart(
                          airPlane: cartController.cartListToCompare[index]['airPlane'] ?? false,
                          name: cartController.cartListToCompare[index]['name'] ?? '',
                          createdAt: cartController.cartListToCompare[index]['creatAt'] ?? '',
                          id: cartController.cartListToCompare[index]['id']!,
                          price: cartController.cartListToCompare[index]['price']!,
                          image: cartController.cartListToCompare[index]['image']!,
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Obx(() {
              double sum = 0;
              for (var element in cartController.list) {
                final double a = double.parse(element['price']);
                sum += a;
              }
              return sum > 50
                  ? const SizedBox.shrink()
                  : Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 14, right: 14, top: 25),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.1), borderRadius: borderRadius5),
                      child: Text(
                        'minSumCount'.tr,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey, fontFamily: gilroySemiBold, fontSize: 16),
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
