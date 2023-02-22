import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nabelli_ecommerce/app/data/models/producer_model.dart';

import '../../constants/constants.dart';

class ProducersService {
  Future<List<ProducersModel>> getProducers() async {
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final List<ProducersModel> categoryList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-producers',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body)['rows'];
      for (final Map product in responseJson) {
        categoryList.add(ProducersModel.fromJson(product));
      }
      return categoryList;
    } else {
      return [];
    }
  }
}
