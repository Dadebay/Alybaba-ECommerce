import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nabelli_ecommerce/app/data/models/aboust_us_model.dart';

import '../../constants/constants.dart';

class AboutUsService {
  Future<AboutUsModel> getAboutUs() async {
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-shop-data',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final responseJson = json.decode(decoded);
      return AboutUsModel.fromJson(responseJson);
    } else {
      return AboutUsModel();
    }
  }

  Future getRules() async {
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-rules',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      return json.decode(decoded);
    } else {
      return response.body;
    }
  }
}
