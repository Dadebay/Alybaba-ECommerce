import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nabelli_ecommerce/app/data/models/history_orders_model.dart';

import '../../constants/constants.dart';
import 'auth_service.dart';

class HistoryOrdersService {
  Future<List<HistoryOrdersModel>> getHistoryOrders() async {
    String lang = Get.locale!.languageCode;
    final token = await Auth().getToken();
     if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final List<HistoryOrdersModel> historyOrders = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/user/$lang/get-orders',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body)['rows'];
      for (final Map product in responseJson) {
        historyOrders.add(HistoryOrdersModel.fromJson(product));
      }
      return historyOrders;
    } else {
      return [];
    }
  }

  Future<HistoryOrdersModelByID> getHistoryByID(int id) async {
    String lang = Get.locale!.languageCode;
    final token = await Auth().getToken();
      if (lang == 'tr' || lang == 'en') {
      lang = 'tm';
    }
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/user/$lang/order/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body)['data'];
      return HistoryOrdersModelByID.fromJson(responseJson);
    } else {
      return HistoryOrdersModelByID();
    }
  }
}
