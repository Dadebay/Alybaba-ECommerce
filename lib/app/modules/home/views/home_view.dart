import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/data/models/aboust_us_model.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/mini_banner_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/new_items_view.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/search_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/services/abous_us_service.dart';
import '../controllers/color_controller.dart';
import '../controllers/home_controller.dart';
import '../local_widgets/home_videos.dart';
import '../local_widgets/in_our_hand_products.dart';
import '../local_widgets/recomended_items_view.dart';
import '../local_widgets/shop_by_brand.dart';
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
      appBar: appBAr(),
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
            NewItemsView(parametrs: const {'new_in_come': 'true'}, future: homeController.productsFuture),
            HomePageVideos(
              videosFuture: homeController.videosFuture,
            ),
            RecomendedItems(parametrs: const {'recomended': 'true'}, future: homeController.productsFutureRecomended),
            const SizedBox(
              height: 30,
            ),
            ShopByBrand(
              producers: homeController.producersFuture,
            ),
            InOurHands(const {'on_hand': 'true'}, homeController.productsFutureInOurHands),
          ],
        ),
      ),
    );
  }

  AppBar appBAr() {
    return AppBar(
      title: Text(
        'home'.tr,
      ),
      elevation: 0,
      backgroundColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      titleTextStyle: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 24),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          defaultBottomSheet(
            child: FutureBuilder<AboutUsModel>(
              future: AboutUsService().getAboutUs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(child: spinKit()),
                  );
                } else if (snapshot.data == null) {
                  return const Text('Empty');
                } else if (snapshot.hasError) {
                  return const Text('Error');
                }
                return Wrap(
                  children: [
                    ListTile(
                      onTap: () {
                        launchUrlString('tel://8-${snapshot.data!.phone1!}');
                      },
                      title: Text(
                        '+993-${snapshot.data!.phone1!}',
                        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                      ),
                      trailing: const Icon(
                        IconlyBroken.arrowRightCircle,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        launchUrlString('tel://8-${snapshot.data!.phone2!}');
                      },
                      title: Text(
                        '+993-${snapshot.data!.phone2!}',
                        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                      ),
                      trailing: const Icon(
                        IconlyBroken.arrowRightCircle,
                        color: Colors.black,
                      ),
                    )
                  ],
                );
              },
            ),
            name: 'callNumber'.tr,
          );
        },
        icon: const Icon(
          IconlyBroken.call,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const SearchPage());
          },
          icon: const Icon(
            IconlyBroken.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
