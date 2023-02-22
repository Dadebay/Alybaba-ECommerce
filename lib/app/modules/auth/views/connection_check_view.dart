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
import '../../cart_page/controllers/cart_page_controller.dart';
import '../../home/controllers/color_controller.dart';
import '../../home/views/banner_profil_view.dart';
import '../../home/views/bottom_nav_bar.dart';
import '../../other_pages/product_profil_view.dart';
import '../../other_pages/show_all_products.dart';
import '../../user_profil/controllers/favorites_page_controller.dart';

class ConnectionCheckView extends StatefulWidget {
  const ConnectionCheckView({Key? key}) : super(key: key);

  @override
  _ConnectionCheckViewState createState() => _ConnectionCheckViewState();
}

class _ConnectionCheckViewState extends State {
  final CartPageController cartPageController = Get.put(CartPageController());
  final FavoritesPageController favPageController = Get.put(FavoritesPageController());
  final ColorController colorController = Get.put(ColorController());

  @override
  void initState() {
    super.initState();
    checkConnection();
    cartPageController.returnCartList();
    favPageController.returnFavList();
    colorController.returnMainColor();
  }

  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 4), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const BottomNavBar();
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
                        color: colorController.findMainColor.value == 0
                            ? kPrimaryColor
                            : colorController.findMainColor.value == 1
                                ? kPrimaryColor1
                                : kPrimaryColor2,
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
                        backgroundColor: colorController.findMainColor.value == 0
                            ? kPrimaryColor
                            : colorController.findMainColor.value == 1
                                ? kPrimaryColor1
                                : kPrimaryColor2,
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
      backgroundColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<BannerModel>>(
              future: BannerService().getBanners(1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.data!.isEmpty) {
                  return const Text('Empty');
                }
                final Random rand = Random();
                final int random = rand.nextInt(snapshot.data!.length);
                return GestureDetector(
                  onTap: () async {
                    if (snapshot.data![random].pathId! == 1) {
                      await Get.to(
                        () => BannerProfileView(
                          description: snapshot.data![random].descriptionTM!,
                          image: '$serverURL/${snapshot.data![random].destination!}-mini.webp',
                          pageName: snapshot.data![random].titleTM!,
                        ),
                      );
                    } else if (snapshot.data![random].pathId == 2) {
                      await Get.to(() => ShowAllProducts(pageName: 'banner', filter: false, parametrs: {'main_category_id': '${snapshot.data![random].itemId}'}));
                    } else if (snapshot.data![random].pathId == 3) {
                      await ProductsService().getProductByID(snapshot.data![random].itemId!).then((value) {
                        Get.to(() => ProductProfilView(name: value.name!, id: value.id!, image: '$serverURL/${value.images!.first}-mini.webp', price: value.price!));
                      });
                    } else {
                      showSnackBar('errorTitle', 'error', Colors.red);
                    }
                  },
                  child: CachedNetworkImage(
                    fadeInCurve: Curves.ease,
                    imageUrl: '$serverURL/${snapshot.data![random].destination!}-mini.webp',
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
              },
            ),
          ),
          const LinearProgressIndicator()
        ],
      ),
    );
  }
}
