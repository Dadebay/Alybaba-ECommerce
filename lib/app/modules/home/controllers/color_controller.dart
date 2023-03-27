import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ColorController extends GetxController {
  final RxInt findMainColor = 0.obs;
  GetStorage getStorage = GetStorage('mainColor');

  dynamic saveColorInt(int a) async {
    findMainColor.value = a;
    await getStorage.write('mainColor', findMainColor.value);
  }

  dynamic returnMainColor() async {
    final a = await getStorage.read('mainColor');
    print(a);
    final result = getStorage.read('cartList') ?? '[]';
    print(result);

    if (a != null) {
      final String a = await getStorage.read('mainColor').toString();
      findMainColor.value = int.parse(a.toString());
    }
  }
}
