import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/photo_view_page.dart';
import 'package:share/share.dart';

import '../../constants/constants.dart';
import '../../constants/widgets.dart';
import '../../data/models/product_model.dart';
import '../../constants/cards/product_card.dart';

AppBar productProfilAppBar(String name, String image) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    backgroundColor: Colors.white,
    title: Text(
      name,
      style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 22),
    ),
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    leading: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 4, left: 8),
        child: const Icon(
          IconlyBroken.arrowLeftCircle,
          size: 30,
          color: Colors.black,
        ),
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Share.share(image, subject: appName);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 8, bottom: 4, right: 15),
          child: Image.asset(
            shareIcon,
            width: 24,
            height: 24,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}

Container productProfilImagePart(List images) {
  return Container(
    color: Colors.white,
    height: Get.size.height / 2.5,
    margin: const EdgeInsets.only(bottom: 15),
    child: CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, count) {
        return GestureDetector(
          onTap: () {
            Get.to(
              () => PhotoViewPage(
                image: "$serverURL/${images[index]['destination']}-big.webp",
              ),
            );
          },
          child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: "$serverURL/${images[index]['destination']}-big.webp",
            imageBuilder: (context, imageProvider) => Container(
              width: Get.size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(child: spinKit()),
            errorWidget: (context, url, error) =>  Center(
                    child: Text('noImage'.tr),
                  ),
          ),
        );
      },
      options: CarouselOptions(
        onPageChanged: (index, CarouselPageChangedReason a) {},
        viewportFraction: 1.0,
        autoPlay: true,
        height: Get.size.height,
        aspectRatio: 4 / 2,
        scrollPhysics: const BouncingScrollPhysics(),
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
      ),
    ),
  );
}

Container productProfilNamePricePart({
  required String name,
  required String price,
  required String barCode,
  required bool kargoIncluded,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 24),
              ),
            ),
            Row(
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontFamily: gilroyBold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 6, top: 7),
                  child: Text(
                    ' TMT',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: gilroySemiBold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Text(
          barCode,
          style: const TextStyle(color: Colors.grey, fontFamily: gilroyMedium, fontSize: 18),
        ),
        kargoIncluded
            ? Text(
                'kargoIncluded'.tr,
                style: const TextStyle(color: Colors.red, fontFamily: gilroySemiBold, fontSize: 19),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}

Container productProfildescriptionPart({
  required String brand,
  required String category,
  required String viewCount,
  required String createdAt,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(15),
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'data'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 21),
          ),
        ),
        twoText(name1: "${"brandPP".tr} : ", name2: brand),
        twoText(name1: "${"category".tr} :", name2: category),
        twoText(name1: 'data3'.tr, name2: viewCount),
        twoText(name1: 'createdAt'.tr, name2: createdAt),
        const SizedBox(
          height: 30,
        ),
        customDivider(),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'description'.tr,
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 21),
          ),
        ),
        Text(
          description,
          style: const TextStyle(fontFamily: gilroyMedium, fontSize: 18, color: Colors.black54),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

Widget twoText({required String name1, required String name2}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name1,
          style: const TextStyle(color: Colors.black54, fontFamily: gilroyMedium, fontSize: 18),
        ),
        Text(
          name2,
          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
        ),
      ],
    ),
  );
}

Container productProfilSameProducts(Size size, Future<List<ProductModel>> products) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(bottom: 35),
    margin: const EdgeInsets.only(top: 20, bottom: 50),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        listViewName('sameProducts', false, size, () {}),
        SizedBox(
          height: 300,
          child: FutureBuilder<List<ProductModel>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.data == null) {
                return const Text('Empty');
              } else if (snapshot.hasError) {
                return const Text('Error');
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    discountValue: snapshot.data![index].discountValue!,
                    discountValueType: snapshot.data![index].discountValueType!,
                    historyOrder: false,
                    id: snapshot.data![index].id!,
                    createdAt: snapshot.data![index].createdAt!,
                    image: '$serverURL/${snapshot.data![index].image!}-mini.webp',
                    name: snapshot.data![index].name!,
                    price: snapshot.data![index].price!,
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
