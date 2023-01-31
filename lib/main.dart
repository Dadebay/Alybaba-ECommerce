import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/auth/views/connection_check_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';

import 'app/constants/utils.dart';
import 'main_dart_helper.dart';

Future<void> main() async {
  mainDartImports();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {});
    myAppOnInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alybaba',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: gilroyRegular,
        colorSchemeSeed: kPrimaryColor,
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: kPrimaryColor, systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarBrightness: Brightness.dark), titleTextStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20), elevation: 0),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent.withOpacity(0)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      fallbackLocale: const Locale('tm'),
      locale: storage.read('langCode') != null
          ? Locale(storage.read('langCode'))
          : const Locale(
              'tm',
            ),
      translations: MyTranslations(),
      defaultTransition: Transition.fade,
      home: ConnectionCheckView(),
    );
  }
}
