import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/cards/product_card.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/local_widget_other_page.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/photo_view_page.dart';
import 'package:share/share.dart';

import '../../constants/buttons/add_cart_button.dart';
import '../../constants/constants.dart';
import '../../constants/errors/empty_widgets.dart';
import '../../constants/errors/error_widgets.dart';

class ProductProfilView extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final int id;
  const ProductProfilView({
    required this.name,
    required this.id,
    required this.image,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductProfilView> createState() => _ProductProfilViewState();
}

class _ProductProfilViewState extends State<ProductProfilView> {
  int selectedColor = -1;
  int selectedSize = -1;
  List<ProductModel> sameProductsList = [];
  late Future<ProductByIDModel> productProfil;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    productProfil = ProductsService().getProductByID(widget.id).then((value) {
      ProductsService().getProducts(parametrs: {'main_category_id': value.mainCategoryId.toString(), 'page': '1', 'limit': '15', 'sort_column': 'random', 'sort_direction': 'ASC'}).then((value) {
        sameProductsList = value;
        setState(() {});
      });

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(
        backArrow: true,
        actionIcon: true,
        icon: GestureDetector(
          onTap: () {
            Share.share(widget.image, subject: appName);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 4, right: 15),
            child: Image.asset(
              shareIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
          ),
        ),
        name: widget.name,
      ),
      body: FutureBuilder<ProductByIDModel>(
        future: productProfil,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(color: Colors.white, child: Center(child: spinKit()));
          } else if (snapshot.data == null) {
            return Container(color: Colors.red, child: Center(child: referalPageEmptyData()));
          } else if (snapshot.hasError) {
            return Container(color: Colors.amber, child: Center(child: referalPageError()));
          }
          final List images = snapshot.data!.images ?? [];
          return Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      color: Colors.white,
                      height: Get.size.height / 2.5,
                      margin: const EdgeInsets.only(bottom: 15),
                      child: images.isEmpty
                          ? noBannerImage()
                          : CarouselSlider.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index, count) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => PhotoViewPageMoreImage(
                                        images: images,
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
                                    placeholder: (context, url) => spinKit(),
                                    errorWidget: (context, url, error) => noBannerImage(),
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
                    ),
                    productProfilNamePricePart(name: snapshot.data!.name!, kargoIncluded: snapshot.data!.kargoIncluded!, price: snapshot.data!.price!, barCode: snapshot.data!.barcode.toString()),
                    productProfildescriptionPart(
                      brand: snapshot.data!.producerName!,
                      category: snapshot.data!.mainCategoryName!,
                      createdAt: snapshot.data!.createdAt!.substring(0, 10),
                      description: snapshot.data!.description!,
                      viewCount: snapshot.data!.viewCount!.toString(),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                        bottom: snapshot.data!.colors!.isEmpty && snapshot.data!.sizes!.isEmpty ? 0 : 35,
                      ),
                      child: Column(
                        children: [
                          snapshot.data!.colors!.isEmpty ? const SizedBox.shrink() : chooseColor(size, snapshot.data!.colors!),
                          snapshot.data!.sizes!.isEmpty ? const SizedBox.shrink() : chooseSize(size, snapshot.data!.sizes!),
                        ],
                      ),
                    ),
                    listViewName('sameProducts', false, size, () {}),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: sameProductsList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          discountValue: sameProductsList[index].discountValue!,
                          discountValueType: sameProductsList[index].discountValueType!,
                          historyOrder: false,
                          id: sameProductsList[index].id!,
                          createdAt: sameProductsList[index].createdAt!,
                          image: '$serverURL/${sameProductsList[index].image!}-mini.webp',
                          name: sameProductsList[index].name!,
                          price: sameProductsList[index].price!,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: size.height * 0.35),
                    ),
                  ],
                ),
              ),
              addCartButtonPart(),
            ],
          );
        },
      ),
    );
  }

  Column chooseColor(Size size, List<ColorModel> colorss) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listViewName('chooseTheColor', false, size, () {}),
        Container(
          height: 90,
          margin: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: colorss.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final String code = colorss[index].color!.substring(1, 7);
              final String codeII = '0xff$code';
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Color(int.parse(codeII)),
                          borderRadius: borderRadius15,
                          border: Border.all(
                            color: colorController.findMainColor.value == 0
                                ? kPrimaryColor
                                : colorController.findMainColor.value == 1
                                    ? kPrimaryColor1
                                    : kPrimaryColor2,
                            width: selectedColor == index ? 4 : 0,
                          ),
                        ),
                      ),
                      Text(
                        colorss[index].name.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroyMedium),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column chooseSize(Size size, List<SizeModel> sizes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listViewName('chooseTheSize', false, size, () {}),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            itemCount: sizes.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSize = index;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius: borderRadius15,
                    border: Border.all(
                      color: selectedSize == index
                          ? colorController.findMainColor.value == 0
                              ? kPrimaryColor
                              : colorController.findMainColor.value == 1
                                  ? kPrimaryColor1
                                  : kPrimaryColor2
                          : Colors.grey.withOpacity(0.8),
                      width: selectedSize == index ? 3 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      sizes[index].name.toString(),
                      style: TextStyle(color: Colors.black, fontFamily: selectedSize == index ? gilroySemiBold : gilroyRegular, fontSize: 18),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bool addCart = false;
  int quantity = 1;
  Container addCartButtonPart() {
    return Container(
      color: kBlackColor,
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'price'.tr,
                style: TextStyle(
                  color: colorController.findMainColor.value == 0
                      ? kPrimaryColor
                      : colorController.findMainColor.value == 1
                          ? kPrimaryColor1
                          : kPrimaryColor2,
                  fontFamily: gilroyRegular,
                  fontSize: 16,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: gilroyBold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, right: 6),
                    child: Text(
                      ' TMT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: gilroyBold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 4,
            child: AddCartButton(
              id: widget.id,
              productProfil: true,
            ),
          ),
        ],
      ),
    );
  }
}
