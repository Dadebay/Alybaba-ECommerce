import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../models/banner_model.dart';
import 'auth_service.dart';

class BannerService {
  Future<List<BannerModel>> getBanners(int id) async {
    final List<BannerModel> bannerList = [];
    String lang = Get.locale!.languageCode;
    if (lang == "tr" || lang == 'en') lang = "tm";
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-banners/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["rows"] as List;
      for (final Map product in responseJson) {
        bannerList.add(BannerModel.fromJson(product));
      }
      return bannerList;
    } else {
      return [];
    }
  }
}

Future<BannerModel> getBannerByID(int id) async {
  final token = await Auth().getToken();

  final response = await http.get(
    Uri.parse(
      '$serverURL/api/v1/banners/$id',
    ),
    headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    final decoded = utf8.decode(response.bodyBytes);
    final responseJson = json.decode(decoded);
    return BannerModel.fromJson(responseJson);
  } else {
    return BannerModel();
  }
}
