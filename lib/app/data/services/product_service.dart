import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../models/product_model.dart';

class ProductsService {
  Future<List<ProductModel>> getProducts({required Map<String, String> parametrs}) async {
    final List<ProductModel> productsList = [];
    String lang = Get.locale!.languageCode;
    if (lang == "tr" || lang == "en") lang = "tm";
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-products',
      ).replace(queryParameters: parametrs),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    // print(parametrs);
    // print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["products"] as List;
      for (final Map product in responseJson) {
        productsList.add(ProductModel.fromJson(product));
      }
      return productsList;
    } else {
      return [];
    }
  }

  Future<ProductByIDModel> getProductByID(int id) async {
    String lang = Get.locale!.languageCode;
    if (lang == "tr" || lang == "en") lang = "tm";
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
