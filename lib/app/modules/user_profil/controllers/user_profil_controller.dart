import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nabelli_ecommerce/app/data/services/auth_service.dart';

class UserProfilController extends GetxController {
  final RxBool userLogin = false.obs;
  File userImage = File('');
  final RxString userName = "0".obs;
  final RxString userReferalCode = "0".obs;
  final RxString userMoney = "".obs;
  final RxString userPhoneNumber = "".obs;
  final RxDouble referalCodeSum = 0.0.obs;
  final RxList userAddressesList = [].obs;

  final storage = GetStorage();

  var tm = const Locale(
    'tm',
  );
  var ru = const Locale(
    'ru',
  );
  var en = const Locale(
    'en',
  );

  @override
  void onInit() {
    super.onInit();
    findUserLogin();
  }

  findUserLogin() async {
    final token = await Auth().getToken();
    if (token != null) {
      userLogin.value = true;
      returnData();
    } else {
      userLogin.value = false;
    }
  }

  dynamic saveData({required String phoneNumber1, required String userName1, required String userMoney1, required String referalCode1}) {
    userName.value = userName1;
    userMoney.value = userMoney1;
    userPhoneNumber.value = phoneNumber1;
    userReferalCode.value = referalCode1;
    storage.write('userName', userName1);
    storage.write('userMoney', userMoney1);
    storage.write('phoneNumber', phoneNumber1);
    storage.write('userReferalCode', referalCode1);
  }

  dynamic returnData() async {
    userName.value = await storage.read('userName') ?? '';
    userMoney.value = await storage.read('userMoney') ?? ' ';
    userPhoneNumber.value = await storage.read('userPhoneNumber') ?? ' ';
    userReferalCode.value = await storage.read('userReferalCode') ?? '';
  }

  dynamic switchLang(String value) {
    if (value == 'en') {
      Get.updateLocale(en);
      storage.write('langCode', 'en');
    } else if (value == 'ru') {
      Get.updateLocale(ru);
      storage.write('langCode', 'ru');
    } else {
      Get.updateLocale(tm);
      storage.write('langCode', 'tm');
    }
    update();
  }

  returnUserAddresses() {
    final result = storage.read('userAddressesList') ?? "[]";
    final List jsonData = jsonDecode(result);
    if (jsonData.isNotEmpty) {
      for (final element in jsonData) {
        addAddressesToList(note: element['note'], address: element['address']);
      }
    }
  }

  clearUserAddresses() {
    userAddressesList.clear();
    final String jsonString = jsonEncode(userAddressesList);
    storage.write("userAddressesList", jsonString);
  }

  dynamic addAddressesToList({required String address, required String note}) async {
    if (userAddressesList.isEmpty) {
      userAddressesList.add({'address': address, 'note': note});
    } else {
      bool value = false;
      for (final element in userAddressesList) {
        if (element["address"] == address && element['note'] == note) {
          value = true;
        }
      }
      if (value == false) {
        userAddressesList.add({'address': address, 'note': note});
      }
      userAddressesList.refresh();
      final String jsonString = jsonEncode(userAddressesList);
      storage.write("userAddressesList", jsonString);
    }
  }
}
