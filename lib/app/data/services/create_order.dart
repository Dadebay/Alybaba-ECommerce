import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/favorites_page_controller.dart';

import '../../constants/constants.dart';
import '../models/get_order_info_model.dart';
import '../models/product_model.dart';
import 'auth_service.dart';

class CreateOrderService {
  final CartPageController cartController = Get.put(CartPageController());

  Future createOrder({required String userName, required String userPhoneNumber, required String address, required String note, required int transport}) async {
    final token = await Auth().getToken();
    final List products = [];
    for (var element in cartController.list) {
      products.add({'id': element['id'], 'size_id': element['sizeID'], 'color_id': element['colorID'], 'count': element['quantity']});
    }
    final response = await http.post(
      Uri.parse('$serverURL/api/user/ru/create-order'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{'note': note, 'phone': userPhoneNumber, 'name': userName, 'address': address, 'transport': transport, 'products': products}),
    );
    return response.statusCode;
  }

  Future<List<ProductModel>> getCartItems(bool cart) async {
    final List list = [];
    if (cart) {
      for (var element in cartController.list) {
        list.add(element['id']);
      }
    } else {
      final FavoritesPageController favoritesPageController = Get.put(FavoritesPageController());
      for (var element in favoritesPageController.favList) {
        list.add(element['id']);
      }
    }
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final List<ProductModel> productsList = [];
    print(list);
    final response = await http.get(
      Uri.parse('$serverURL/api/$lang/get-selected-products').replace(
        queryParameters: {
          'products': jsonEncode(list),
        },
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map product in responseJson) {
        productsList.add(ProductModel.fromJson(product));
      }
      cartController.cartListToCompare.clear();
      for (var element in productsList) {
        cartController.cartListToCompare.add({
          'id': element.id,
          'name': element.name,
          'image': '$serverURL/${element.image!}-mini.webp',
          'price': element.price,
          'creatAt': element.createdAt,
          'airPlane': element.airplane!,
        });
      }
      return productsList;
    } else {
      return [];
    }
  }

  Future<GetOrderInfoModel> getOrderInfo() async {
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-order-info',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      return GetOrderInfoModel.fromJson(responseJson);
    } else {
      return GetOrderInfoModel();
    }
  }
}
