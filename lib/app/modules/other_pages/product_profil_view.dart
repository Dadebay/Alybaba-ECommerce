import 'package:flutter/material.dart';
import 'package:nabelli_ecommerce/app/constants/cards/product_card.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/local_widget_other_page.dart';
import 'package:share/share.dart';

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

  dynamic getData() {
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
            return Container(color: Colors.white, child: spinKit());
          } else if (snapshot.data == null) {
            return Container(color: Colors.red, child: referalPageEmptyData());
          } else if (snapshot.hasError) {
            return Container(color: Colors.amber, child: referalPageError());
          }
          final List images = snapshot.data!.images ?? [];
          return Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    imagesView(images),
                    productProfilNamePricePart(
                      name: snapshot.data!.name!,
                      kargoIncluded: snapshot.data!.kargoIncluded!,
                      price: snapshot.data!.price!,
                      barCode: snapshot.data!.barcode.toString(),
                      dostawkaPrice: snapshot.data!.weightPrice.toString(),
                    ),
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
              addCartButtonPart(price: widget.price, id: widget.id),
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
                            color: colorController.mainColor,
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
                      color: selectedSize == index ? colorController.mainColor : Colors.grey.withOpacity(0.8),
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
}
