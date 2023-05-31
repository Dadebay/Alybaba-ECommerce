import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/mini_banner_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../controllers/color_controller.dart';
import '../controllers/home_controller.dart';
import '../local_widgets/home_videos.dart';
import '../local_widgets/in_our_hand_products.dart';
import '../local_widgets/new_items_view.dart';
import '../local_widgets/recomended_items_view.dart';
import 'banners.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    homeController.getData();
    setState(() {});
  }

  final ColorController colorController = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBAr(context),
      body: SmartRefresher(
        footer: footer(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        enablePullUp: false,
        physics: const ClampingScrollPhysics(),
        header: MaterialClassicHeader(
          color: colorController.findMainColor.value == 0
              ? kPrimaryColor
              : colorController.findMainColor.value == 1
                  ? kPrimaryColor1
                  : kPrimaryColor2,
        ),
        child: ListView(
          children: [
            Banners(future: homeController.bannersFuture),
            MiniBannersView(homeController.minibannerFuture),
            NewItemsView(parametrs: const {'new_in_come': 'true', 'sort_column': 'created_at', 'sort_direction': 'DESC'}, future: homeController.productsFuture),
            HomePageVideos(
              videosFuture: homeController.videosFuture,
            ),
            RecomendedItems(parametrs: const {'recomended': 'true', 'sort_column': 'random', 'sort_direction': 'ASC'}, future: homeController.productsFutureRecomended),
            const SizedBox(
              height: 30,
            ),
            // ShopByBrand(
            // producers: homeController.producersFuture,
            // ),
            InOurHands(
              data: homeController.productsFutureInOurHands,
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController textEditingController = TextEditingController();
  AppBar appBAr(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorController.findMainColor.value == 0
            ? kPrimaryColor
            : colorController.findMainColor.value == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
      ),
      leadingWidth: 0.0,
      titleSpacing: 0.0,
      shadowColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      foregroundColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      scrolledUnderElevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      title: Container(
        width: Get.size.width,
        child: searchField(textEditingController, context),
      ),
    );
  }
}
