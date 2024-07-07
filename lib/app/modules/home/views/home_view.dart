import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/cards/product_card.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/modules/home/views/banners.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/widgets.dart';
import '../controllers/color_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List pageName = ['newItems', 'inOurHands', 'recomendedItems'];
  final HomeController homeController = Get.put(HomeController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    homeController.getData();
    setState(() {});
  }

  final ColorController colorController2 = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SmartRefresher(
      footer: footer(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      enablePullUp: false,
      physics: const ClampingScrollPhysics(),
      header: MaterialClassicHeader(
        color: colorController2.mainColor,
      ),
      child: ListView(
        children: [
          Banners(
            future: homeController.bannersFuture,
            miniBanner: false,
          ),
          Banners(
            future: homeController.minibannerFuture,
            miniBanner: true,
          ),
          products(size: size, index: 0, future: homeController.newItemsProducts),
          products(size: size, index: 1, future: homeController.productsFutureRecomended),
          products(size: size, index: 2, future: homeController.productsFutureInOurHands),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget products({
    required Size size,
    required int index,
    required Future<List<ProductModel>> future,
  }) {
    return Wrap(
      children: [
        listViewName(pageName[index], true, size, () {
          Get.to(() => ShowAllProducts(pageName: pageName[index], parametrs: homeController.parameters[index]));
        }),
        SizedBox(
          height: size.width >= 800 ? 400 : 300,
          child: FutureBuilder<List<ProductModel>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loaderCollar();
              } else if (snapshot.data == null) {
                return const SizedBox.shrink();
              } else if (snapshot.hasError) {
                return const SizedBox.shrink();
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    historyOrder: false,
                    discountValue: snapshot.data![index].discountValue!,
                    discountValueType: snapshot.data![index].discountValueType!,
                    id: snapshot.data![index].id!,
                    createdAt: snapshot.data![index].createdAt!,
                    image: '$serverURL/${snapshot.data![index].image!}-mini.webp',
                    name: snapshot.data![index].name!,
                    price: snapshot.data![index].price!,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
