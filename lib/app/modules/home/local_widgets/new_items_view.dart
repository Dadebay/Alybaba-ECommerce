import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../constants/cards/product_card.dart';

class NewItemsView extends GetView {
  final Map<String, String> parametrs;
  NewItemsView({required this.parametrs, required this.future});
  final Future<List<ProductModel>> future;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        listViewName("newItems", true, size, () {
          Get.to(() => ShowAllProducts(pageName: "newItems", filter: false, parametrs: parametrs));
        }),
        SizedBox(
          height: 300,
          child: FutureBuilder<List<ProductModel>>(
              future: future,
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
                      image: "$serverURL/${snapshot.data![index].image!}-mini.webp",
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
