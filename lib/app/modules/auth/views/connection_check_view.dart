// ignore_for_file: file_names, always_use_package_imports

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/banner_model.dart';
import '../../../data/services/banner_service.dart';
import '../../../data/services/product_service.dart';
import '../../home/views/banner_profil_view.dart';
import '../../home/views/bottom_nav_bar.dart';
import '../../other_pages/product_profil_view.dart';
import '../../other_pages/show_all_products.dart';

class ConnectionCheckView extends StatefulWidget {
  @override
  _ConnectionCheckViewState createState() => _ConnectionCheckViewState();
}

class _ConnectionCheckViewState extends State with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 4), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return BottomNavBar();
              },
            ),
          );
        });
      }
    } on SocketException catch (_) {
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius20),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: borderRadius20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'noConnection1'.tr,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: kPrimaryColor,
                        fontFamily: gilroyMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text(
                        'noConnection2'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: gilroyMedium,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          checkConnection();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: borderRadius10,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      ),
                      child: Text(
                        'noConnection3'.tr,
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: gilroyMedium),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 70,
                minRadius: 60,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/icons/noconnection.gif',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<BannerModel>>(
                  future: BannerService().getBanners(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: spinKit());
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    } else if (snapshot.data!.isEmpty) {
                      return Text("Empty");
                    }
                    Random rand = Random();
                    int random = rand.nextInt(snapshot.data!.length);
                    return GestureDetector(
                      onTap: () async {
                        String lang = await Get.locale!.languageCode.toString();
                        if (snapshot.data![random].pathId! == 1) {
                          Get.to(() => BannerProfileView(
                                description: lang == 'tm' ? snapshot.data![random].descriptionTM! : snapshot.data![random].descriptionRU!,
                                image: "$serverURL/${snapshot.data![random].destination!}-big.webp",
                                pageName: lang == 'tm' ? snapshot.data![random].titleTM! : snapshot.data![random].titleRU!,
                              ));
                        } else if (snapshot.data![random].pathId == 2) {
                          Get.to(() => ShowAllProducts(pageName: 'banner', parametrs: {'main_category_id': '${snapshot.data![random].itemId}'}));
                        } else if (snapshot.data![random].pathId == 3) {
                          ProductsService().getProductByID(snapshot.data![random].itemId!).then((value) {
                            Get.to(() => ProductProfilView(name: value.name!, id: value.id!, image: "$serverURL/${value.images![0]}-big.webp", price: value.price!));
                          });
                        } else {
                          showSnackBar('errorTitle', 'error', Colors.red);
                        }
                      },
                      child: CachedNetworkImage(
                        fadeInCurve: Curves.ease,
                        imageUrl: "$serverURL/${snapshot.data![random].destination!}-big.webp",
                        imageBuilder: (context, imageProvider) => Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: borderRadius10,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: spinKit()),
                        errorWidget: (context, url, error) => Center(
                          child: noBannerImage(),
                        ),
                      ),
                    );
                  })),
          LinearProgressIndicator()
        ],
      ),
    );
  }
}
