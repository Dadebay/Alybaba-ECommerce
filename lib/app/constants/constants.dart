import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/views/cart_view.dart';
import 'package:nabelli_ecommerce/app/modules/category/views/category_view.dart';
import 'package:nabelli_ecommerce/app/modules/home/views/home_view.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/views/user_profil_view.dart';

// String serverURL = 'http://216.250.12.49:5001';
String serverURL = 'http://alybaba.com.tm';
const Color kPrimaryColor = Color(0xfffd7e15);
const Color kPrimaryColor1 = Color(0xff1f2123);
const Color kPrimaryColor2 = Color(0xff6366f1);
const Color kPrimaryColor3 = Color(0xff6605ff);
const Color backgroundColor = Color(0xfff2f2f2);
const Color kBlackColor = Color(0xff2b2b2b);

//Bottom nav bar List
List page = [const HomeView(), const CategoriesView(), const CartView(), const UserProfilView()];
List pageTitle = ['home'.tr, 'category'.tr, 'cart'.tr, 'profil'.tr];
List icons = [IconlyLight.home, IconlyLight.category, IconlyLight.buy, IconlyLight.profile];
List iconsBold = [IconlyBold.home, IconlyBold.category, IconlyBold.buy, IconlyBold.profile];
List iconsAppBar = [homeViewAppBar(), SizedBox.shrink(), DeleteButton(), CallButton()];

///BorderRadius
const BorderRadius borderRadius5 = BorderRadius.all(Radius.circular(5));
const BorderRadius borderRadius10 = BorderRadius.all(Radius.circular(10));
const BorderRadius borderRadius15 = BorderRadius.all(Radius.circular(15));
const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(20));
const BorderRadius borderRadius25 = BorderRadius.all(Radius.circular(25));
const BorderRadius borderRadius30 = BorderRadius.all(Radius.circular(30));
const BorderRadius borderRadius40 = BorderRadius.all(Radius.circular(40));
const BorderRadius borderRadius50 = BorderRadius.all(Radius.circular(50));
/////////////////////////////////
const String gilroyBold = 'GilroyBold';
const String gilroySemiBold = 'GilroySemiBold';
const String gilroyMedium = 'GilroyMedium';
const String gilroyRegular = 'GilroyRegular';
//Language icons
const String tmIcon = 'assets/image/tm.png';
const String ruIcon = 'assets/image/ru.png';
const String trIcon = 'assets/image/tr.png';
const String engIcon = 'assets/image/uk.png';
///////////////////
const String logo = 'assets/icons/logo.png';
const String noData = 'assets/lottie/noData.json';
const String shareIcon = 'assets/icons/share1.png';
const String appName = 'Alybaba';
const String appShareLink = 'https://play.google.com/store/apps/details?id=com.gurbanow.alybaba&pli=1';
const String loremImpsum =
    'Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir,Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir,Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir,Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir';
/////////////////////////////////////////////////
const String emptyCartLottie = 'assets/lottie/emptyCART.json';
const String noDataLottie = 'assets/lottie/noData.json';
const String playButtonLottie = 'assets/lottie/playButton.json';
const String pinLottie = 'assets/lottie/pin.json';
const String heartLottie = 'assets/lottie/heart.json';

////////////////////////////////////////////////
const List sortData = [
  {
    'id': 1,
    'sort_direction': 'sortDefault',
    'sort_column': 'sortDefault',
    'sort_name': 'sortDefault',
  },
  {
    'id': 2,
    'sort_column': 'price',
    'sort_direction': 'ASC',
    'sort_name': 'sortPriceHighToLow',
  },
  {
    'id': 3,
    'sort_column': 'price',
    'sort_direction': 'DESC',
    'sort_name': 'sortPriceLowToHigh',
  },
  {
    'id': 4,
    'sort_column': 'created_at',
    'sort_direction': 'ASC',
    'sort_name': 'sortCreatedAtHighToLow',
  },
  {
    'id': 5,
    'sort_column': 'created_at',
    'sort_direction': 'DESC',
    'sort_name': 'sortCreatedAtLowToHigh',
  },
  {
    'id': 6,
    'sort_column': 'view_count',
    'sort_direction': 'ASC',
    'sort_name': 'sortViewsDESC',
  },
  {
    'id': 7,
    'sort_column': 'view_count',
    'sort_direction': 'DESC',
    'sort_name': 'sortViewsASC',
  },
];
const List cities = [
  'Aşgabat',
  'Ahal',
  'Mary',
  'Lebap',
  'Daşoguz',
  'Balkan',
];
const List transport = [
  'Airplane',
  'Truck',
  'Boat',
];
