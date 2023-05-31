import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/product_model.dart';
import '../../../constants/cards/product_card.dart';
import '../../other_pages/show_all_products.dart';

class InOurHands extends StatelessWidget {
  final Future<List<ProductModel>> data;

  const InOurHands({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Wrap(
      children: [
        listViewName('inOurHands', true, size, () {
          Get.to(() => ShowAllProducts(pageName: 'inOurHands', filter: false, parametrs: {'on_hand': 'true', 'sort_column': 'random', 'sort_direction': 'ASC'}));
        }),
        FutureBuilder<List<ProductModel>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.data == null) {
              return const SizedBox.shrink();
            } else if (snapshot.hasError) {
              return const SizedBox.shrink();
            }
            return GridView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  discountValue: snapshot.data![index].discountValue!,
                  discountValueType: snapshot.data![index].discountValueType!,
                  historyOrder: false,
                  id: snapshot.data![index].id!,
                  createdAt: snapshot.data![index].createdAt!,
                  image: '$serverURL/${snapshot.data![index].image!}-mini.webp',
                  name: snapshot.data![index].name!,
                  price: snapshot.data![index].price!,
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 5),
            );
          },
        )
      ],
    );
  }
}
