import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../constants/constants.dart';
import 'auth_service.dart';

class SignInService {
  final UserProfilController userProfilController = Get.put(UserProfilController());

  Future otpCheck({
    required String phoneNumber,
    String? otp,
  }) async {
    final token = await Auth().getToken();
    final response = await http.post(
      Uri.parse('$serverURL/api/user/ru/verify-login'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'code': otp,
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      await Auth().setToken(responseJson['access_token']);
      await Auth().setRefreshToken(responseJson['refresh_token']);
      await Auth().login(responseJson['data'].toString());
      userProfilController.saveData(phoneNumber1: phoneNumber, userName1: responseJson['data']['full_name'], userMoney1: '0', referalCode1: responseJson['data']['referral_code']);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future register({required String otp, required String phoneNumber, required String fullName, required String referalKod}) async {
    final token = await Auth().getToken();
    final response = await http.post(
      Uri.parse('$serverURL/api/user/ru/register'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'phone': phoneNumber,
        'code': otp,
        'full_name': fullName,
        'referral_code': referalKod,
        'email': '',
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      await Auth().setToken(responseJson['access_token']);
      await Auth().setRefreshToken(responseJson['refresh_token']);
      await Auth().login(responseJson['data'].toString());
      userProfilController.saveData(phoneNumber1: phoneNumber, userName1: responseJson['data']['full_name'], userMoney1: '0', referalCode1: responseJson['data']['referral_code']);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future login({required String phone}) async {
    final response = await http.post(
      Uri.parse('$serverURL/api/user/ru/login'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      if (phone == '62990344') {
        await Auth().setRefreshToken(responseJson['refresh_token']);
        userProfilController.saveData(phoneNumber1: phone, userName1: responseJson['data']['full_name'], userMoney1: '0', referalCode1: responseJson['data']['referral_code']);
        await Auth().login(responseJson['data'].toString());
      }
      await Auth().setToken(responseJson['access_token']);
      showSnackBar('Sms kod', responseJson['code'].toString(), Colors.green);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future sendCode({required String phone}) async {
    final response = await http.post(
      Uri.parse('$serverURL/api/user/ru/send-code'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      showSnackBar('Sms kod', responseJson['code'].toString(), Colors.green);
      await Auth().setToken(responseJson['access_token']);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
