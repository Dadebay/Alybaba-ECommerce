import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/modules/buttons/agree_button_view.dart';
import 'package:nabelli_ecommerce/app/modules/cards/product_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/widgets.dart';

class ShowAllProducts extends StatefulWidget {
  ShowAllProducts({
    Key? key,
    required this.pageName,
    required this.getData,
  }) : super(key: key);
  final Future<List<ProductModel>> getData;
  final String pageName;
  @override
  State<ShowAllProducts> createState() => _ShowAllProductsState();
}

class _ShowAllProductsState extends State<ShowAllProducts> {
  String name = 'Ashgabat';

  int value = 0;

  final TextEditingController _controller = TextEditingController();

  final TextEditingController _controller1 = TextEditingController();

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

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
                  cursorColor: kPrimaryColor,
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
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
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
                  cursorColor: kPrimaryColor,
                  controller: controller2,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: Padding(padding: const EdgeInsets.only(right: 8), child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: gilroySemiBold, fontSize: 14, color: Colors.grey.shade400))),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: 'maxPrice'.tr,
                    hintStyle: TextStyle(fontFamily: gilroyMedium, fontSize: 16, color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
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

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomSheet: sortFilter(),
      appBar: AppBar(
        title: Text(
          widget.pageName.tr,
          maxLines: 1,
          style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 22),
        ),
        leading: IconButton(
          icon: Icon(
            IconlyBroken.arrowLeftCircle,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
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
          color: kPrimaryColor,
        ),
        child: FutureBuilder<List<ProductModel>>(
            future: widget.getData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data == null) {
                return Center(child: Text("Empty no Product"));
              } else if (snapshot.hasError) {
                return Center(child: Text("Error"));
              }
              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ProductCard(
                  id: snapshot.data![index].id!,
                  sizeList: snapshot.data![index].sizes!,
                  colorList: snapshot.data![index].colors!,
                  airPlane: snapshot.data![index].airplane!,
                  createdAt: snapshot.data![index].createdAt!,
                  image: "$serverURL/${snapshot.data![index].image!}-big.webp",
                  name: snapshot.data![index].name!,
                  price: snapshot.data![index].price!,
                ),
                staggeredTileBuilder: (index) => StaggeredTile.count(
                  1,
                  index % 2 == 0 ? 1.5 : 1.6,
                ),
              );
            }),
      ),
    );
  }

  Widget sortFilter() {
    return Container(
      width: Get.size.width,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 60,
        margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: BoxDecoration(color: kBlackColor, borderRadius: borderRadius15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
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
                          activeColor: kPrimaryColor,
                          groupValue: value,
                          onChanged: (ind) {
                            final int a = int.parse(ind.toString());
                            value = a;
                            Get.back();
                          },
                          title: Text(
                            "${sortData[index]["name"]}".tr,
                            style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular),
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
                    Icon(
                      IconlyBold.swap,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "sort".tr,
                        style: TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.white,
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  defaultBottomSheet(
                    name: 'Filter'.tr,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          selectCity(),
                          Divider(
                            color: kPrimaryColor.withOpacity(0.4),
                            thickness: 2,
                          ),
                          twoTextEditingField(controller1: _controller, controller2: _controller1),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: AgreeButton(
                              onTap: () {
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        IconlyBold.filter2,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "filter".tr,
                        style: TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding selectCity() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('selectCityTitle'.tr, style: const TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 14)),
            Text(name.tr, style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18)),
          ],
        ),
        leading: const Icon(
          IconlyBroken.location,
          size: 30,
        ),
        trailing: const Icon(IconlyBroken.arrowRightCircle),
        onTap: () {
          Get.defaultDialog(
            title: 'selectCityTitle'.tr,
            titleStyle: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroyMedium),
            radius: 5,
            backgroundColor: Colors.white,
            titlePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            contentPadding: const EdgeInsets.only(),
            content: Column(
              children: List.generate(
                5,
                (index) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    dividerr(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          name = cities[index];
                        });
                        Get.back();
                      },
                      child: Text(
                        cities[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
