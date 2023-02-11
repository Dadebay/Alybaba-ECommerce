import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/data/models/aboust_us_model.dart';
import 'package:nabelli_ecommerce/app/data/models/producer_model.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/mini_banner_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/new_items_view.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/search_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/banner_model.dart';
import '../../../data/services/abous_us_service.dart';
import '../../../data/services/banner_service.dart';
import '../../../data/services/producers_service.dart';
import '../local_widgets/home_videos.dart';
import '../local_widgets/in_our_hand_products.dart';
import '../local_widgets/recomended_items_view.dart';
import '../local_widgets/shop_by_brand.dart';
import 'banners.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<BannerModel>> bannersFuture;
  late Future<List<BannerModel>> minibannerFuture;
  late Future<List<ProductModel>> productsFuture;
  late Future<List<ProductModel>> productsFutureInOurHands;
  late Future<List<ProductModel>> productsFutureRecomended;
  late Future<List<ProducersModel>> producersFuture;
  @override
  void initState() {
    super.initState();
    getData();
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    getData();
    setState(() {});
  }

  getData() {
    minibannerFuture = BannerService().getBanners(3);
    bannersFuture = BannerService().getBanners(2);
    productsFuture = ProductsService().getProducts(parametrs: {'new_in_come': 'true'});
    productsFutureInOurHands = ProductsService().getProducts(parametrs: {'on_hand': 'true'});
    productsFutureRecomended = ProductsService().getProducts(parametrs: {'recomended': 'true'});
    producersFuture = ProducersService().getProducers();
  }

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
          physics: const BouncingScrollPhysics(),
          header: MaterialClassicHeader(
            color: kPrimaryColor,
          ),
          child: ListView(
            children: [
              Banners(future: bannersFuture),
              MiniBannersView(minibannerFuture),
              NewItemsView({'new_in_come': 'true'}),
              HomePageVideos(),
              RecomendedItems({'recomended': 'true'}),
              SizedBox(
                height: 30,
              ),
              ShopByBrand(
                producers: producersFuture,
              ),
              InOurHands({'on_hand': 'true'}),
            ],
          ),
        ));
  }

  AppBar appBAr() {
    return AppBar(
      title: Text(
        'home'.tr,
      ),
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 24),
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
                        return Text("Empty");
                      } else if (snapshot.hasError) {
                        return Text("Error");
                      }
                      return Wrap(
                        children: [
                          ListTile(
                            onTap: () {
                              launchUrlString("tel://+993-${snapshot.data!.phone1!}");
                            },
                            title: Text(
                              '+993-${snapshot.data!.phone1!}',
                              style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                            ),
                            trailing: Icon(
                              IconlyBroken.arrowRightCircle,
                              color: Colors.black,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              launchUrlString("tel://+993-${snapshot.data!.phone2!}");
                            },
                            title: Text(
                              '+993-${snapshot.data!.phone2!}',
                              style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                            ),
                            trailing: Icon(
                              IconlyBroken.arrowRightCircle,
                              color: Colors.black,
                            ),
                          )
                        ],
                      );
                    }),
                name: 'callNumber'.tr);
          },
          icon: Icon(
            IconlyBroken.call,
            color: Colors.white,
          )),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => SearchPage());
            },
            icon: Icon(
              IconlyBroken.search,
              color: Colors.white,
            )),
      ],
    );
  }
}
