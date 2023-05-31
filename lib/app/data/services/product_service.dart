import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../models/product_model.dart';

class ProductsService {
  Future<List<ProductModel>> getProducts({required Map<String, String> parametrs}) async {
    String lang = Get.locale!.languageCode;
    final List<ProductModel> productsList = [];
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-products',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['products'] as List;
      for (final Map product in responseJson) {
        productsList.add(ProductModel.fromJson(product));
      }
      return productsList;
    } else {
      return [];
    }
  }

  Future<List<ProductModel>> getShowAllProducts({required Map<String, String> parametrs}) async {
    final HomeController homeController = Get.put(HomeController());
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    print(parametrs);
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-products',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      homeController.loading.value = 3;
      final responseJson = jsonDecode(response.body)['products'] as List;
      if (jsonDecode(response.body)['products'] == null || jsonDecode(response.body)['products'].toString() == '[]') {
        // showSnackBar("noProductTitle", "noProductSubtitle", Colors.red);
      } else {
        for (final Map product in responseJson) {
          homeController.showAllList.add({
            'id': ProductModel.fromJson(product).id,
            'name': ProductModel.fromJson(product).name,
            'price': ProductModel.fromJson(product).price,
            'createdAt': ProductModel.fromJson(product).createdAt,
            'image': ProductModel.fromJson(product).image,
            'discountValue': ProductModel.fromJson(product).discountValue,
            'discountValueType': ProductModel.fromJson(product).discountValueType,
          });
        }
        if (homeController.showAllList.isEmpty) {
          homeController.loading.value = 2;
        }
      }

      return [];
    } else {
      homeController.loading.value = 1;
      return [];
    }
  }

  Future<ProductByIDModel> getProductByID(int id) async {
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-product/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return ProductByIDModel.fromJson(responseJson[0]);
    } else {
      return ProductByIDModel();
    }
  }
}
