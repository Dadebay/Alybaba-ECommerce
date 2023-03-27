import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartPageController extends GetxController {
  RxList list = [].obs;
  RxList cartListToCompare = [].obs;
  final storage = GetStorage();
  void addToCard({required int id, required String price, required String image, required String name, required String createdAt, required bool airplane, required int sizeID, required int colorID}) {
    if (list.isEmpty) {
      list.add({'id': id, 'price': price, 'image': image, 'name': name, 'createdAt': createdAt, 'quantity': 1, 'sizeID': sizeID, 'colorID': colorID, 'airplane': airplane});
    } else {
      bool value = false;
      for (final element in list) {
        if (element['id'] == id) {
          element['quantity'] += 1;
          value = true;
        }
      }
      if (!value) {
        list.add({'id': id, 'price': price, 'name': name, 'image': image, 'createdAt': createdAt, 'quantity': 1, 'sizeID': sizeID, 'colorID': colorID, 'airplane': airplane});
      }
    }
    list.refresh();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
  }

  dynamic returnCartList() {
    final result = storage.read('cartList') ?? '[]';
    final List jsonData = jsonDecode(result);
    if (jsonData.isEmpty) {
    } else {
      for (final element in jsonData) {
        list.add({
          'id': element['id'],
          'price': element['price'],
          'image': element['image'],
          'name': element['name'],
          'createdAt': element['createdAt'],
          'quantity': element['quantity'],
          'sizeID': element['sizeID'],
          'colorID': element['colorID'],
          'airplane': element['airplane']
        });
      }
    }
  }

  void updateCartQuantity(int id) {
    for (var element in list) {
      if (element['id'] == id) {
        element['quantity'] += 1;
      }
    }
    list.refresh();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
  }

  void minusCardElement(int id) {
    for (final element in list) {
      if (element['id'] == id) {
        element['quantity'] -= 1;
        if (element['quantity'] == 0) {
          cartListToCompare.removeWhere((element) => element['id'] == id);
        }
      }
    }

    list.removeWhere((element) => element['quantity'] == 0);
    list.refresh();
    cartListToCompare.refresh();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
  }

  void removeCardXButton(int id) {
    cartListToCompare.removeWhere((element) => element['id'] == id);
    list.removeWhere((element) => element['id'] == id);
    list.refresh();
    cartListToCompare.refresh();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
  }

  void removeAllCartElements() {
    list.clear();
    cartListToCompare.clear();
    cartListToCompare.refresh();
    final String jsonString = jsonEncode(list);
    storage.write('cartList', jsonString);
  }
}
