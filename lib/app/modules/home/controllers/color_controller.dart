import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ColorController extends GetxController {
  final RxInt findMainColor = 0.obs;
  final storage = GetStorage('mainColor');

  dynamic saveColorInt(int a) {
    findMainColor.value = a;
    storage.write('mainColor', findMainColor.value);
  }

  dynamic returnMainColor() async {
    if (await storage.read('mainColor') != null) {
      final String a = await storage.read('mainColor');
      findMainColor.value = int.parse(a.toString());
    }
  }
}
