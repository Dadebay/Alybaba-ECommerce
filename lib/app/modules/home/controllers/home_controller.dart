import 'dart:ui';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxString balance = '0'.obs;
  RxBool agreeButton = false.obs;
  RxInt videoSelectedIndex = 0.obs;
  RxInt loading = 0.obs;
  RxInt page = 0.obs;
  RxList showAllList = [].obs;

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
