import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nabelli_ecommerce/app/data/models/video_model.dart';

import '../../constants/constants.dart';

class VideosService {
  Future<List<VideosModel>> getVideos() async {
    final List<VideosModel> videosList = [];
    String lang = Get.locale!.languageCode;
    if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/$lang/get-videos',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map product in responseJson) {
        videosList.add(VideosModel.fromJson(product));
      }
      return videosList;
    } else {
      return [];
    }
  }
}
