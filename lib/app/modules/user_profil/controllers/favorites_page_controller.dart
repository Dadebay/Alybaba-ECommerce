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
        if (element["id"] == id) {
          value = true;
        }
      }
      if (value == true) {
        favList.removeWhere((element) => element["id"] == id);
        print('remoive etdim mana geldi');
      } else if (value == false) {
        favList.add({
          "id": id,
        });
      }
      print(favList);
      favList.refresh();
      final String jsonString = jsonEncode(favList);
      storage.write("favList", jsonString);
    }
  }

  returnFavList() {
    final result = storage.read('favList') ?? "[]";
    final List jsonData = jsonDecode(result);
    if (jsonData.isNotEmpty) {
      for (final element in jsonData) {
        toggleFav(element["id"]);
      }
    }
  }

  clearFavList() {
    favList.clear();
    final String jsonString = jsonEncode(favList);
    storage.write("favList", jsonString);
  }
}
