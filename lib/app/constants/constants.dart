import 'package:flutter/material.dart';

const String serverURL = 'http://95.85.127.250:5001';
// const String serverURL = 'http://192.168.1.6:5001';
Color kPrimaryColor = Color(0xfffd7e15);
const Color backgroundColor = Color(0xfff2f2f2);
const Color kBlackColor = Color(0xff2b2b2b);

///BorderRadius
const BorderRadius borderRadius5 = BorderRadius.all(Radius.circular(5));
const BorderRadius borderRadius10 = BorderRadius.all(Radius.circular(10));
const BorderRadius borderRadius15 = BorderRadius.all(Radius.circular(15));
const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(20));
const BorderRadius borderRadius25 = BorderRadius.all(Radius.circular(25));
const BorderRadius borderRadius30 = BorderRadius.all(Radius.circular(30));
const BorderRadius borderRadius40 = BorderRadius.all(Radius.circular(40));
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
const String appShareLink = 'https://play.google.com/store/apps/developer?id=Bilermen+Nesil';
const String loremImpsum =
    'Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir,Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir,Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir,Lorem ipsum, yaygın olarak kullanılan bir yer tutucu metne verilen isimdir. Dolgu veya sahte metin olarak da bilinen bu tip yer tutucu metinler, aslında anlamlı bir şey söylemeden bir alanı doldurmaya yarayan metinlerdir';
/////////////////////////////////////////////////

const List sortData = [
  {
    'id': 1,
    'name': 'sortDefault',
    'sort_column': '',
  },
  {
    'id': 2,
    'name': 'sortPriceLowToHigh',
    'sort_column': 'expensive',
  },
  {
    'id': 3,
    'name': 'sortPriceHighToLow',
    'sort_column': 'cheap',
  },
  {
    'id': 4,
    'name': 'sortCreatedAtHighToLow',
    'sort_column': 'latest',
  },
  {
    'id': 5,
    'name': 'sortCreatedAtLowToHigh',
    'sort_column': 'oldest',
  },
  {
    'id': 6,
    'name': 'sortViews',
    'sort_column': 'views',
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
  //order type
  //1 airplane
  // 2 tyr
  // 3 gami
  'Airplane',
  'Truck',
  'Boat',
];
