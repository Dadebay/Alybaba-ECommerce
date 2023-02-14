// api/user/ru/get-referrals
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nabelli_ecommerce/app/data/models/spec_model.dart';

import '../../constants/constants.dart';

class SpecServices {
  Future<List<GetCatSpecsModel>> getCatSpecs({required int subCategoryID}) async {
    final List<GetCatSpecsModel> referalList = [];
    String lang = Get.locale!.languageCode;
     if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-cat-specs/$subCategoryID',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map product in responseJson) {
        referalList.add(GetCatSpecsModel.fromJson(product));
      }
      return referalList;
    } else {
      return [];
    }
  }
}
