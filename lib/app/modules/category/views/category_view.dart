// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/models/producer_model.dart';
import 'package:nabelli_ecommerce/app/data/services/producers_service.dart';
import 'package:nabelli_ecommerce/app/modules/cards/brand_card.dart';
import 'package:nabelli_ecommerce/app/modules/cards/category_card.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/category_service.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  TabBar tabbar() {
    return TabBar(
      labelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 20),
      unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 18),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      labelPadding: const EdgeInsets.only(top: 8, bottom: 4),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.white,
      indicatorWeight: 2,
      tabs: [
        Tab(
          text: 'categoriesMini'.tr,
        ),
        Tab(
          text: 'brands'.tr,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("categoriesMini".tr),
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 24),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(color: kPrimaryColor, child: tabbar()),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<List<CategoryModel>>(
                      future: CategoryService().getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: spinKit());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error"));
                        } else if (snapshot.data!.isEmpty) {
                          return Center(child: Text("Empty"));
                        }
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemExtent: 220,
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              subCategoryList: snapshot.data![index].subCategory!,
                              id: snapshot.data![index].id!,
                              image: "$serverURL/${snapshot.data![index].image!}-big.webp",
                              name: snapshot.data![index].name!,
                            );
                          },
                        );
                      }),
                  FutureBuilder<List<ProducersModel>>(
                      future: ProducersService().getProducers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: spinKit());
                        } else if (snapshot.hasError) {
                          return Text('Error');
                        } else if (snapshot.data!.isEmpty) {
                          return Text('Empty');
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BrandCard(
                              id: snapshot.data![index].id!,
                              image: "$serverURL/${snapshot.data![index].image!}-big.webp",
                              name: snapshot.data![index].name!,
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
