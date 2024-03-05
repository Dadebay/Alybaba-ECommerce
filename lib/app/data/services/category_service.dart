import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../models/category_model.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final List<CategoryModel> categoryList = [];
    print('comes here');
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-categories',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    print(response.body.toString());
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body)['rows'];
      for (final Map product in responseJson) {
        categoryList.add(CategoryModel.fromJson(product));
      }
      return categoryList;
    } else {
      return [];
    }
  }
}
