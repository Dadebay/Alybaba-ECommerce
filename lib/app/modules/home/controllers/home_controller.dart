import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/banner_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/banner_service.dart';
import '../../../data/services/product_service.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxString balance = '0'.obs;
  RxBool agreeButton = false.obs;
  RxInt loading = 0.obs;
  RxInt page = 0.obs;
  RxList showAllList = [].obs;

  late Future<List<BannerModel>> bannersFuture;
  late Future<List<BannerModel>> minibannerFuture;
  late Future<List<ProductModel>> newItemsProducts;
  List parameters = [
    {'new_in_come': 'true', 'page': '0', 'limit': '20', 'sort_column': 'random', 'sort_direction': 'DESC'},
    {'recomended': 'true', 'page': '0', 'limit': '20', 'sort_column': 'random', 'sort_direction': 'ASC'},
    {'on_hand': 'true', 'page': '0', 'limit': '20', 'sort_column': 'random', 'sort_direction': 'ASC'},
  ];

  //
  late Future<List<ProductModel>> productsFutureInOurHands;
  late Future<List<ProductModel>> productsFutureRecomended;
  dynamic getData() {
    minibannerFuture = BannerService().getBanners(3);
    bannersFuture = BannerService().getBanners(2);
    newItemsProducts = ProductsService().getProducts(parametrs: parameters[0]);
    productsFutureRecomended = ProductsService().getProducts(parametrs: parameters[1]);
    productsFutureInOurHands = ProductsService().getProducts(
      parametrs: parameters[2],
    );
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  final storage = GetStorage();

  var tm = const Locale(
    'tr',
  );
  var ru = const Locale(
    'ru',
  );

  dynamic switchLang(String value) {
    if (value == 'ru') {
      Get.updateLocale(ru);
      storage.write('langCode', 'ru');
    } else {
      Get.updateLocale(tm);
      storage.write('langCode', 'tr');
    }
    update();
  }
}
