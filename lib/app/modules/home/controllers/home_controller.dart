import 'dart:ui';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/banner_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/producer_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/video_model.dart';
import '../../../data/services/banner_service.dart';
import '../../../data/services/category_service.dart';
import '../../../data/services/producers_service.dart';
import '../../../data/services/product_service.dart';
import '../../../data/services/video_services.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxString balance = '0'.obs;
  RxBool agreeButton = false.obs;
  RxInt videoSelectedIndex = 0.obs;
  RxInt loading = 0.obs;
  RxInt page = 0.obs;
  RxList showAllList = [].obs;
  late Future<List<CategoryModel>> category;
  late Future<List<ProducersModel>> producer;
  late Future<List<BannerModel>> bannersFuture;
  late Future<List<BannerModel>> minibannerFuture;
  late Future<List<ProductModel>> productsFuture;
  late Future<List<ProductModel>> productsFutureInOurHands;
  late Future<List<ProductModel>> productsFutureRecomended;
  // late Future<List<ProducersModel>> producersFuture;
  late Future<List<VideosModel>> videosFuture;
  dynamic getData() {
    minibannerFuture = BannerService().getBanners(3);
    bannersFuture = BannerService().getBanners(2);
    productsFuture = ProductsService().getProducts(parametrs: {'new_in_come': 'true', 'sort_column': 'created_at', 'sort_direction': 'DESC'});
    productsFutureInOurHands = ProductsService().getProducts(
      parametrs: {'on_hand': 'true', 'limit': '20', 'page': '1', 'sort_column': 'random', 'sort_direction': 'ASC'},
    );
    productsFutureRecomended = ProductsService().getProducts(parametrs: {'recomended': 'true', 'sort_column': 'random', 'sort_direction': 'ASC'});
    // producersFuture = ProducersService().getProducers();
    videosFuture = VideosService().getVideos();
  }

  @override
  void onInit() {
    super.onInit();
    category = CategoryService().getCategories();
    producer = ProducersService().getProducers();
    getData();
  }

  late VideoPlayerController controller;
  late FlickManager flickManager;
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
