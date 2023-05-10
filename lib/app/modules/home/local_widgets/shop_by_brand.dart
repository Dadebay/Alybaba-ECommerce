import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/producer_model.dart';

class ShopByBrand extends StatelessWidget {
  const ShopByBrand({
    required this.producers,
    Key? key,
  }) : super(key: key);
  final Future<List<ProducersModel>> producers;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Text(
                  'shopByBrand'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 22, fontFamily: gilroyBold),
                ),
              ),
              SizedBox(
                height: size.width >= 800 ? 200 : 100,
                child: FutureBuilder<List<ProducersModel>>(
                  future: producers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: spinKit());
                    } else if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    } else if (snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ShowAllProducts(pageName: snapshot.data![index].name!, filter: false, parametrs: {'producer_id': snapshot.data![index].id!.toString()}));
                          },
                          child: Container(
                            width: size.width >= 800 ? 240 : 140,
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: backgroundColor,
                              borderRadius: borderRadius10,
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                fadeInCurve: Curves.ease,
                                width: 90,
                                height: 900,
                                imageUrl: '$serverURL/${snapshot.data![index].image!}-mini.webp',
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
                                  child: Text('noImage'.tr),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
