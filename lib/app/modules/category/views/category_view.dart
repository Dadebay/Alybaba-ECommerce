// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/models/producer_model.dart';
import 'package:nabelli_ecommerce/app/constants/cards/brand_card.dart';
import 'package:nabelli_ecommerce/app/constants/cards/category_card.dart';
import '../../../constants/custom_app_bar.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/category_model.dart';
import '../../home/controllers/home_controller.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final HomeController homeController = Get.put(HomeController());

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(
          actionIcon: false,
          backArrow: false,
          name: 'category',
        ),
        body: Column(
          children: [
            Container(
              color: colorController.findMainColor.value == 0
                  ? kPrimaryColor
                  : colorController.findMainColor.value == 1
                      ? kPrimaryColor1
                      : kPrimaryColor2,
              child: tabbar(),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<List<CategoryModel>>(
                    future: homeController.category,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: spinKit());
                      } else if (snapshot.hasError) {
                        return referalPageEmptyData();
                      } else if (snapshot.data!.isEmpty) {
                        return referalPageError();
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
                            image: '$serverURL/${snapshot.data![index].image!}-mini.webp',
                            name: snapshot.data![index].name!,
                          );
                        },
                      );
                    },
                  ),
                  FutureBuilder<List<ProducersModel>>(
                    future: homeController.producer,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: spinKit());
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.data!.isEmpty) {
                        return const Text('Empty');
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BrandCard(
                            id: snapshot.data![index].id!,
                            image: '$serverURL/${snapshot.data![index].image!}-mini.webp',
                            name: snapshot.data![index].name!,
                            productCount: '20 ',
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
