import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ColorController extends GetxController {
  final RxInt findMainColor = 0.obs;
  final getStorage = GetStorage();

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
    print(a);
    print(a);
    print(a);
    if (a != null) {
      final String a = await getStorage.read('mainColor').toString();
      findMainColor.value = int.parse(a.toString());
    }
  }
}
