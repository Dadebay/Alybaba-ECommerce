import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/data/services/history_order_service.dart';

import '../../../constants/cards/product_card.dart';
import '../../../constants/constants.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../constants/widgets.dart';
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
      backgroundColor: backgroundColor,
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
            itemExtent: 210,
            // reverse: true,
            // shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => HistoryOrderProductProfil(
                      id: snapshot.data![index].id!,
                      pageName: "${"order".tr} ${snapshot.data!.length - index}",
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(borderRadius: borderRadius10, color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 3, spreadRadius: 3)]),
                  child: Column(
                    children: [
                      topPart(index, snapshot),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: Get.size.width,
                          child: ListView.builder(
                            itemCount: snapshot.data![index].items!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int indexx) {
                              return Container(
                                margin: const EdgeInsets.all(8),
                                width: 60,
                                decoration: const BoxDecoration(
                                  borderRadius: borderRadius10,
                                  color: Colors.amber,
                                ),
                                child: ClipRRect(
                                  borderRadius: borderRadius10,
                                  child: CachedNetworkImage(
                                    fadeInCurve: Curves.ease,
                                    imageUrl: "$serverURL/${snapshot.data![index].items![indexx]['image']!}-mini.webp",
                                    imageBuilder: (context, imageProvider) => Container(
                                      width: Get.size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: borderRadius10,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(child: spinKit()),
                                    errorWidget: (context, url, error) => Center(
                                      child: Text('noImage'.tr),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          bottomPart1('products', '${snapshot.data![index].items!.length} haryt '),
                          bottomPart1('status', snapshot.data![index].statusText!),
                          bottomPart1('sum', '${snapshot.data![index].total.toString().substring(0, snapshot.data![index].total!.length - 3)} TMT'),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget bottomPart1(String name1, String name2) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name1.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 16, fontFamily: gilroyMedium),
          ),
          Text(
            name2.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black, fontSize: 15, fontFamily: gilroySemiBold),
          ),
        ],
      ),
    );
  }

  Row topPart(int index, AsyncSnapshot<List<HistoryOrdersModel>> snapshot) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${"order".tr} ${index + 1}",
              style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: gilroySemiBold),
            ),
            Text(
              snapshot.data![index].createdAt!,
              style: const TextStyle(color: Colors.grey, fontSize: 15, fontFamily: gilroyRegular),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            IconlyLight.arrowRightCircle,
            color: Colors.black,
            size: 25,
          ),
        )
      ],
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
