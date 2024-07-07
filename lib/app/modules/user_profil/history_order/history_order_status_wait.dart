import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/cards/order_history_card.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/services/history_order_service.dart';

import '../../../constants/cards/product_card.dart';
import '../../../constants/constants.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../data/models/history_orders_model.dart';

class OrderStatusWait extends StatelessWidget {
  final int whichStatus;
  const OrderStatusWait({
    required this.whichStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'orders'),
      body: FutureBuilder<List<HistoryOrdersModel>>(
        future: HistoryOrdersService().getHistoryOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return referalPageError();
          } else if (snapshot.data!.isEmpty) {
            return orderPageEmpty();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemExtent: 240,
            itemBuilder: (BuildContext context, int index) {
              return OrderHistoryCard(index: index, snapshot: snapshot);
            },
          );
        },
      ),
    );
  }
}

class HistoryOrderProductProfil extends StatelessWidget {
  const HistoryOrderProductProfil({required this.id, required this.pageName, Key? key}) : super(key: key);
  final int id;
  final String pageName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backArrow: true,
        actionIcon: false,
        name: pageName,
      ),
      body: FutureBuilder<HistoryOrdersModelByID>(
        future: HistoryOrdersService().getHistoryByID(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: snapshot.data!.items!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ProductCard(
                    id: snapshot.data!.items![index].id!,
                    createdAt: DateTime.now().toString(),
                    historyOrder: true,
                    discountValue: 0,
                    discountValueType: 0,
                    image: '$serverURL/${snapshot.data!.items![index].image}-mini.webp',
                    name: snapshot.data!.items![index].name!,
                    price: snapshot.data!.items![index].price!,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 5),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 3, spreadRadius: 3)]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'orderDetails'.tr,
                      style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    bottomPart2('date', snapshot.data!.createdAt!),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: bottomPart2('countProducts', snapshot.data!.items!.length.toString()),
                    ),
                    bottomPart2('priceProduct', '${snapshot.data!.total!.substring(0, snapshot.data!.total!.length - 3)} TMT'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Row bottomPart2(String name, String name1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name.tr,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
        ),
        Text(
          name1,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 18),
        ),
      ],
    );
  }
}
