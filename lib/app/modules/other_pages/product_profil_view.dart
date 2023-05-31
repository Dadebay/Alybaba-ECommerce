import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';

import '../../constants/constants.dart';
import '../../constants/buttons/add_cart_button.dart';
import '../../constants/errors/empty_widgets.dart';
import '../../constants/errors/error_widgets.dart';
import 'local_widget_other_page.dart';

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
  late Future<ProductByIDModel> productProfil;
  late Future<List<ProductModel>> getSameProducts;
  @override
  void initState() {
    super.initState();
    productProfil = ProductsService().getProductByID(widget.id).then((value) {
      print(value.mainCategoryId);
      getSameProducts = ProductsService().getProducts(parametrs: {'main_category_id': value.mainCategoryId.toString(), 'sort_column': 'random', 'sort_direction': 'ASC'});

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: productProfilAppBar(
        widget.name,
        widget.image,
      ),
      body: FutureBuilder<ProductByIDModel>(
        future: productProfil,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(color: Colors.white, child: Center(child: spinKit()));
          } else if (snapshot.data == null) {
            return Container(color: Colors.white, child: Center(child: referalPageEmptyData()));
          } else if (snapshot.hasError) {
            return Container(color: Colors.white, child: Center(child: referalPageError()));
          }
          return Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                    ),
                    child: ListView(
                      children: [
                        productProfilImagePart(snapshot.data!.images!),
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
                        productProfilSameProducts(size, getSameProducts),
                      ],
                    ),
                  ),
                ),
              ),
              addCartButtonPart()
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
                      )
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
          )
        ],
      ),
    );
  }
}
