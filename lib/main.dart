import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import 'app/constants/notification_service.dart';
import 'app/constants/utils.dart';
import 'app/modules/auth/views/connection_check_view.dart';
import 'app/modules/home/controllers/color_controller.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  await FCMConfig().sendNotification(body: message.notification!.body!, title: message.notification!.title!);
  return;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await FCMConfig().requestPermission();
  await FCMConfig().initAwesomeNotification();
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

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
  int colorCode = 0;
  changeColor() async {
    final a = await storage.read('mainColor');
    if (a != null) {
      final String a = await storage.read('mainColor').toString();
      colorCode = int.parse(a.toString());
      colorController.findMainColor.value = colorCode;
      setState(() {});
    }
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {});
    FCMConfig().requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      FCMConfig().sendNotification(body: message.notification!.body!, title: message.notification!.title!);
    });
    print(storage.read('mainColor'));
    colorController.returnMainColor();
    changeColor();
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
        colorSchemeSeed: colorCode == 0
            ? kPrimaryColor
            : colorCode == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: colorCode == 0
              ? kPrimaryColor
              : colorCode == 1
                  ? kPrimaryColor1
                  : kPrimaryColor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: colorCode == 0
                ? kPrimaryColor
                : colorCode == 1
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
