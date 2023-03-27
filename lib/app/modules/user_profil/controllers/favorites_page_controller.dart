import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoritesPageController extends GetxController {
  final RxList favList = [].obs;
  final RxList favList2ToShow = [].obs;
  final storage = GetStorage();

  dynamic toggleFav(int id) async {
    if (favList.isEmpty) {
      favList.add({'id': id});
    } else {
      bool value = false;
      for (final element in favList) {
        if (element['id'] == id) {
          value = true;
        }
      }
      if (value) {
        favList.removeWhere((element) => element['id'] == id);
      } else if (!value) {
        favList.add({
          'id': id,
        });
      }
    }
    favList.refresh();
    final String jsonString = jsonEncode(favList);
    await storage.write('favList', jsonString);
  }

  dynamic returnFavList() async {
    final a = storage.read('favList');
    if (storage.read('favList') != null) {
      final result = storage.read('favList') ?? '[]';
      final List jsonData = jsonDecode(result);
      if (jsonData.isEmpty) {
      } else {
        for (final element in jsonData) {
          toggleFav(int.parse(element['id'].toString()));
        }
      }
    }
  }

  dynamic clearFavList() {
    favList.clear();
    final String jsonString = jsonEncode(favList);
    storage.write('favList', jsonString);
  }
}
