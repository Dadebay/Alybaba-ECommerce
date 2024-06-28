import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

class ColorController extends GetxController {
  final RxInt findMainColor = 0.obs;
  final getStorage = GetStorage();
  Color mainColor = kPrimaryColor;
  dynamic getMainColor() {
    if (findMainColor.value == 0) {
      mainColor = kPrimaryColor;
    } else if (findMainColor.value == 1) {
      mainColor = kPrimaryColor1;
    } else {
      mainColor = kPrimaryColor2;
    }
    return mainColor;
  }

  dynamic saveColorInt(int a) async {
    findMainColor.value = a;

    await getStorage.write('mainColor', a);
    update();
  }

  dynamic returnMainColor() async {
    await GetStorage.init();
    getStorage.read('cartList');
    getStorage.read('langCode');
    final a = await getStorage.read('mainColor');
    if (a != null) {
      final String a = await getStorage.read('mainColor').toString();
      findMainColor.value = int.parse(a.toString());
    }
  }
}
