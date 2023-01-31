import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/producer_model.dart';
import '../../../data/services/product_service.dart';

class ShopByBrand extends StatelessWidget {
  const ShopByBrand({Key? key, required this.producers}) : super(key: key);
  final Future<List<ProducersModel>> producers;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Text(
                  "shopByBrand".tr,
                  style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: gilroyBold),
                ),
              ),
              Container(
                height: 100,
                child: FutureBuilder<List<ProducersModel>>(
                    future: producers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: spinKit());
                      } else if (snapshot.hasError) {
                        return Text("Error");
                      } else if (snapshot.data!.isEmpty) {
                        return Text('Empty');
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => ShowAllProducts(
                                    pageName: snapshot.data![index].name!,
                                    getData: ProductsService().getProducts(parametrs: {'producer_id': snapshot.data![index].id!.toString()}),
                                  ));
                            },
                            child: Container(
                              width: 140,
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: borderRadius10,
                              ),
                              child: Center(
                                child: CachedNetworkImage(
                                  fadeInCurve: Curves.ease,
                                  width: 90,
                                  height: 900,
                                  imageUrl: "$serverURL/${snapshot.data![index].image!}-big.webp",
                                  imageBuilder: (context, imageProvider) => Container(
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
                                    child: Text('No Image'),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }
}