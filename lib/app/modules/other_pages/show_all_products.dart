import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/cards/product_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/errors/empty_widgets.dart';
import '../../constants/errors/error_widgets.dart';
import '../../constants/widgets.dart';
import '../../data/services/product_service.dart';
import '../home/controllers/home_controller.dart';

class ShowAllProducts extends StatefulWidget {
  const ShowAllProducts({
    required this.pageName,
    required this.filter,
    required this.parametrs,
    Key? key,
  }) : super(key: key);

  final bool filter;
  final String pageName;
  final Map<String, String> parametrs;

  @override
  State<ShowAllProducts> createState() => _ShowAllProductsState();
}

class _ShowAllProductsState extends State<ShowAllProducts> {
  Map<String, String> getDataMine = {};
  String name = 'Ashgabat';
  int value = 0;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getDataMine.addAll(widget.parametrs);
    homeController.showAllList.clear();
    homeController.page.value = 0;
    homeController.loading.value = 0;
    addDataToMap();
  }

  dynamic addDataToMap() {
    getDataMine.addAll({
      'limit': '10',
      'page': '${homeController.page.value}',
    });
    setState(() {});
    getData();
  }

  Widget twoTextEditingField({required TextEditingController controller1, required TextEditingController controller2}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: Text('priceRange'.tr, style: const TextStyle(fontSize: 19, color: Colors.black)),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18),
                  cursorColor: colorController.findMainColor.value == 0
                      ? kPrimaryColor
                      : colorController.findMainColor.value == 1
                          ? kPrimaryColor1
                          : kPrimaryColor2,
                  controller: controller1,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: gilroyBold, fontSize: 14, color: Colors.grey.shade400)),
                    ),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: 'minPrice'.tr,
                    hintStyle: TextStyle(fontFamily: gilroyMedium, fontSize: 16, color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(
                        color: colorController.findMainColor.value == 0
                            ? kPrimaryColor
                            : colorController.findMainColor.value == 1
                                ? kPrimaryColor1
                                : kPrimaryColor2,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                ),
              ),
              Container(
                width: 15,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 2,
                color: Colors.grey,
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18),
                  cursorColor: colorController.findMainColor.value == 0
                      ? kPrimaryColor
                      : colorController.findMainColor.value == 1
                          ? kPrimaryColor1
                          : kPrimaryColor2,
                  controller: controller2,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: gilroySemiBold, fontSize: 14, color: Colors.grey.shade400)),
                    ),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: 'maxPrice'.tr,
                    hintStyle: TextStyle(fontFamily: gilroyMedium, fontSize: 16, color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(
                        color: colorController.findMainColor.value == 0
                            ? kPrimaryColor
                            : colorController.findMainColor.value == 1
                                ? kPrimaryColor1
                                : kPrimaryColor2,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector filterWidget() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              IconlyBold.filter2,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'filter'.tr,
              style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector sortWidget() {
    return GestureDetector(
      onTap: () {
        defaultBottomSheet(
          name: 'sort'.tr,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: sortData.length,
            itemBuilder: (context, index) {
              return RadioListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                value: index,
                tileColor: Colors.black,
                selectedTileColor: Colors.black,
                activeColor: colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
                groupValue: value,
                onChanged: (ind) {
                  final int a = int.parse(ind.toString());
                  value = a;
                  homeController.showAllList.clear();
                  homeController.page.value = 0;
                  getDataMine.update(
                    'page',
                    (value) {
                      return homeController.page.value.toString();
                    },
                  );
                  getDataMine.addAll({
                    'sort_column': sortData[index]['sort_column'],
                    'sort_direction': sortData[index]['sort_direction'],
                  });
                  getData();
                  Get.back();
                },
                title: Text(
                  "${sortData[index]["sort_name"]}".tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                ),
              );
            },
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            IconlyBold.swap,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'sort'.tr,
              style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget sortFilter() {
    return SizedBox(
      width: Get.size.width,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(color: kBlackColor, borderRadius: borderRadius15),
        child: widget.filter
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: sortWidget(),
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 1,
                    child: filterWidget(),
                  ),
                ],
              )
            : Center(child: sortWidget()),
      ),
    );
  }

  final HomeController homeController = Get.put(HomeController());
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    homeController.showAllList.clear();
    getDataMine.update(
      'page',
      (value) {
        return value = '0';
      },
    );
    homeController.loading.value = 0;
    getData();
  }

  dynamic getData() async {
    await ProductsService().getShowAllProducts(parametrs: getDataMine);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: sortFilter(),
      appBar: AppBar(
        title: Text(
          widget.pageName.tr,
          maxLines: 1,
          style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(
            IconlyBroken.arrowLeftCircle,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: colorController.findMainColor.value == 0
            ? kPrimaryColor
            : colorController.findMainColor.value == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
        elevation: 0,
      ),
      body: SmartRefresher(
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
    );
  }
}
