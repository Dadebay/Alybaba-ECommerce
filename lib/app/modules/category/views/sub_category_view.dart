// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/data/models/category_model.dart';
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
  final List<SubCategoryModel> subCategoryList;
  final int categoryID;
  final String categoryName;

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  int selecetedIndex = 0;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    homeController.page.value += 1;
    getDataMine.update(
      'page',
      (value) {
        return value = homeController.page.value.toString();
      },
    );
    getData();
  }

  Map<String, String> getDataMine = {};

  final HomeController homeController = Get.put(HomeController());
  void _onRefresh() async {
    _refreshController.refreshCompleted();
    homeController.showAllList.clear();
    getDataMine.addAll({'limit': '10', 'page': '${homeController.page.value}', 'sub_category_id': '${widget.subCategoryList[selecetedIndex].id}', 'main_category_id': widget.categoryID.toString()});

    homeController.loading.value = 0;
    getData();
  }

  @override
  void initState() {
    super.initState();
    homeController.showAllList.clear();
    homeController.page.value = 0;
    homeController.loading.value = 0;
    addDataToMap();
  }

  dynamic addDataToMap() {
    getDataMine.addAll({'limit': '10', 'page': '${homeController.page.value}', 'sub_category_id': '${widget.subCategoryList[selecetedIndex].id}', 'main_category_id': widget.categoryID.toString()});
    setState(() {});
    getData();
  }

  dynamic getData() async {
    await ProductsService().getShowAllProducts(parametrs: getDataMine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: widget.categoryName),
      body: Column(
        children: [
          Container(
            height: 60,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.subCategoryList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selecetedIndex = index;
                      _onRefresh();
                    });
                  },
                  child: Container(
                    width: Get.size.width / 3,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius20,
                      color: selecetedIndex == index ? kPrimaryColor : Colors.white,
                      border: Border.all(color: selecetedIndex == index ? kPrimaryColor : Colors.white),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.subCategoryList[index].name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
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
                color: colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
              ),
              child: Obx(() {
                if (homeController.loading.value == 0) {
                  return Center(child: spinKit());
                } else if (homeController.loading.value == 1) {
                  return referalPageError();
                } else if (homeController.loading.value == 2) {
                  return referalPageEmptyData();
                }
                return homeController.showAllList.isEmpty
                    ? referalPageEmptyData()
                    : GridView.builder(
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
          )
        ],
      ),
    );
  }
}
