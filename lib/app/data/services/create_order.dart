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
  Future createOrder({required String userName, required String userPhoneNumber, required String address, required String note, required int transport}) async {
    final token = await Auth().getToken();
    final CartPageController cartController = Get.put(CartPageController());
    List products = [];
    cartController.list.forEach((element) {
      products.add({'id': element['id'], "size_id": element['sizeID'], "color_id": element['colorID'], "count": element['quantity']});
    });
    final response = await http.post(
      Uri.parse('$serverURL/api/user/ru/create-order'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{'note': note, 'phone': userPhoneNumber, 'name': userName, 'address': address, 'transport': transport, "products": products}),
    );
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<List<ProductModel>> getCartItems(bool cart) async {
    List list = [];

    if (cart == true) {
      final CartPageController cartPageController = Get.put(CartPageController());
      cartPageController.list.forEach((element) {
        list.add(element['id']);
      });
    } else {
      final FavoritesPageController favoritesPageController = Get.put(FavoritesPageController());
      favoritesPageController.favList.forEach((element) {
        list.add(element['id']);

      });
    }

    final List<ProductModel> productsList = [];

    final response = await http.get(
      Uri.parse('$serverURL/api/ru/get-selected-products').replace(queryParameters: {
        'products': jsonEncode(list),
      }),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["rows"] as List;
      for (final Map product in responseJson) {
        productsList.add(ProductModel.fromJson(product));
      }
      return productsList;
    } else {
      return [];
    }
  }

  Future<GetOrderInfoModel> getOrderInfo() async {
    String lang = Get.locale!.languageCode;
    if (lang == "tr") lang = "tm";
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
