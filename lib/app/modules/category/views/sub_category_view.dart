// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/category_model.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/cards/product_card.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/services/product_service.dart';
import '../../home/controllers/home_controller.dart';

class SubCategoryView extends StatefulWidget {
  SubCategoryView({
    required this.subCategoryList,
    required this.categoryID,
    required this.categoryName,
    Key? key,
  }) : super(key: key);

  final int categoryID;
  final String categoryName;
  final List<SubCategoryModel> subCategoryList;

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  Map<String, String> parametrs = {};
  final HomeController homeController = Get.put(HomeController());
  final ColorController colorController = Get.put(ColorController());

  int selecetedIndex = -1;
  TextEditingController textEditingController = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    homeController.showAllList.clear();
    homeController.page.value = 0;
    homeController.loading.value = 0;
    getProducts();
  }

  dynamic getProducts() async {
    parametrs.addAll({'limit': '10', 'page': '${homeController.page.value}', 'sort_column': 'random', 'sort_direction': 'ASC', 'main_category_id': widget.categoryID.toString()});
    await ProductsService().getShowAllProducts(parametrs: parametrs);
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    homeController.page.value += 1;
    parametrs.update(
      'page',
      (value) {
        return value = homeController.page.value.toString();
      },
    );
    await ProductsService().getShowAllProducts(parametrs: parametrs);
  }

  void _onRefresh() async {
    _refreshController.refreshCompleted();
    homeController.showAllList.clear();
    homeController.loading.value = 0;
    homeController.page.value = 0;
    parametrs.addAll({'limit': '10', 'page': '${homeController.page.value}', 'main_category_id': widget.categoryID.toString(), 'sort_column': 'random', 'sort_direction': 'ASC'});
    await ProductsService().getShowAllProducts(parametrs: parametrs);
  }

  void _onTapRefresh() async {
    _refreshController.refreshCompleted();
    homeController.showAllList.clear();
    homeController.loading.value = 0;
    homeController.page.value = 0;
    parametrs.addAll({
      'limit': '10',
      'page': '${homeController.page.value}',
      'sort_column': 'random',
      'sort_direction': 'ASC',
      'sub_category_id': '${widget.subCategoryList[selecetedIndex].id}',
      'main_category_id': widget.categoryID.toString(),
    });
    await ProductsService().getShowAllProducts(parametrs: parametrs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: widget.categoryName),
      body: Column(
        children: [
          subCategoryView(),
          Expanded(
            child: SmartRefresher(
              footer: footer(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              enablePullDown: true,
              enablePullUp: true,
              physics: const BouncingScrollPhysics(),
              header: MaterialClassicHeader(
                color: colorController.mainColor,
              ),
              child: Obx(() {
                if (homeController.loading.value == 0) {
                  return loaderShowAllProducts();
                } else if (homeController.loading.value == 1) {
                  return referalPageError();
                } else if (homeController.loading.value == 2) {
                  return referalPageEmptyData();
                } else if (homeController.showAllList.isEmpty && homeController.loading.value == 3) {
                  return referalPageEmptyData();
                }
                return GridView.builder(
                  itemCount: homeController.showAllList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ProductCard(
                    id: homeController.showAllList[index]['id'],
                    historyOrder: false,
                    discountValue: int.parse(homeController.showAllList[index]['discountValue'].toString()),
                    discountValueType: int.parse(homeController.showAllList[index]['discountValueType'].toString()),
                    createdAt: homeController.showAllList[index]['createdAt'],
                    image: "$serverURL/${homeController.showAllList[index]['image']}-mini.webp",
                    name: homeController.showAllList[index]['name'],
                    price: homeController.showAllList[index]['price'],
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 5),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget subCategoryView() {
    return Container(
      height: 90,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.subCategoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selecetedIndex = index;
                _onTapRefresh();
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 8, left: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: borderRadius20,
                color: selecetedIndex == index ? colorController.mainColor : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                widget.subCategoryList[index].name.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: selecetedIndex == index ? Colors.white : Colors.black, fontFamily: selecetedIndex == index ? gilroyBold : gilroyMedium, fontSize: 16),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 5,
        ),
      ),
    );
  }
}
