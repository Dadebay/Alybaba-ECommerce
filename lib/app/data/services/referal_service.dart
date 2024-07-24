// api/user/ru/get-referrals
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../../modules/user_profil/controllers/user_profil_controller.dart';
import '../models/referal_model.dart';
import 'auth_service.dart';

class ReferalService {
  Future<List<ReferalModel>> getReferrals() async {
    final UserProfilController userProfilController = Get.put(UserProfilController());
    userProfilController.referalCodeSum.value = 0.0;
    final List<ReferalModel> referalList = [];
    String lang = Get.locale!.languageCode;
      if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final token = await Auth().getToken();

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/user/$lang/get-referrals',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map product in responseJson) {
        referalList.add(ReferalModel.fromJson(product));
        userProfilController.referalCodeSum.value += double.parse(ReferalModel.fromJson(product).sum.toString());
      }
      return referalList;
    } else {
      return [];
    }
  }
}
