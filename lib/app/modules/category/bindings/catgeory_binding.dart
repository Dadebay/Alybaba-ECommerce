import 'package:get/get.dart';

import '../controllers/catgeory_controller.dart';

class CatgeoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatgeoryController>(
      () => CatgeoryController(),
    );
  }
}
