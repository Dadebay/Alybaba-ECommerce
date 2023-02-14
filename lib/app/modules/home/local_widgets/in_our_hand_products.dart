import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/product_model.dart';
import '../../../constants/cards/product_card.dart';
import '../../other_pages/show_all_products.dart';

class InOurHands extends GetView {
  final Map<String, String> parametrs;
  final Future<List<ProductModel>> future;

  const InOurHands(this.parametrs, this.future, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Wrap(
      children: [
        listViewName('inOurHands', true, size, () {
          Get.to(() => ShowAllProducts(pageName: 'inOurHands', filter: false, parametrs: parametrs));
        }),
        SizedBox(
          height: 300,
          child: FutureBuilder<List<ProductModel>>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.data == null) {
                  return const Text('Empty');
                } else if (snapshot.hasError) {
                  return const Text('Error');
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(
                      historyOrder: false,
                      id: snapshot.data![index].id!,
                      createdAt: snapshot.data![index].createdAt!,
                      image: '$serverURL/${snapshot.data![index].image!}-mini.webp',
                      name: snapshot.data![index].name!,
                      price: snapshot.data![index].price!,
                    );
                  },
                );
              },),
        )
      ],
    );
  }
}
