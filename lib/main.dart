import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import 'app/constants/utils.dart';
import 'app/modules/auth/views/connection_check_view.dart';
import 'app/modules/home/controllers/color_controller.dart';
import 'dart:io' show Platform;

import 'main_dart_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
    mainDartImports();
  }
  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();
  final ColorController colorController = Get.put(ColorController());

  @override
  void initState() {
    if (Platform.isAndroid) {
      FirebaseMessaging.instance.getToken().then((value) {});
      myAppOnInit();
    } else if (Platform.isIOS) {
      // iOS-specific code
    }
    colorController.returnMainColor();

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
        colorSchemeSeed: colorController.findMainColor.value == 0
            ? kPrimaryColor
            : colorController.findMainColor.value == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: colorController.findMainColor.value == 0
              ? kPrimaryColor
              : colorController.findMainColor.value == 1
                  ? kPrimaryColor1
                  : kPrimaryColor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: colorController.findMainColor.value == 0
                ? kPrimaryColor
                : colorController.findMainColor.value == 1
                    ? kPrimaryColor1
                    : kPrimaryColor2,
            statusBarBrightness: Brightness.dark,
          ),
          titleTextStyle: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
          elevation: 0,
        ),
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
      home: const ConnectionCheckView(),
    );
  }
}
