import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/product_model.dart';
import '../../cards/product_card.dart';
import '../../other_pages/show_all_products.dart';

class RecomendedItems extends GetView {
  final Future<List<ProductModel>> recomendedFuture;

  RecomendedItems(this.recomendedFuture);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Wrap(
      children: [
        listViewName("recomendedItems", true, size, () {
          Get.to(() => ShowAllProducts(pageName: "recomendedItems", getData: recomendedFuture));
        }),
        SizedBox(
          height: 300,
          child: FutureBuilder<List<ProductModel>>(
              future: recomendedFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.data == null) {
                  return Text("Empty");
                } else if (snapshot.hasError) {
                  return Text("Error");
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(
                      id: snapshot.data![index].id!,
                 
                      createdAt: snapshot.data![index].createdAt!,
                      image: "$serverURL/${snapshot.data![index].image!}-big.webp",
                      name: snapshot.data![index].name!,
                      price: snapshot.data![index].price!,
                    );
                  },
                );
              }),
        )
      ],
    );
  }
}
