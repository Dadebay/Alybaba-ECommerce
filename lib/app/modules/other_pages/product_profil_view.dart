import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';

import '../../constants/constants.dart';
import '../buttons/add_cart_button.dart';
import 'local_widget_other_page.dart';

class ProductProfilView extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final int id;
  ProductProfilView({Key? key, required this.name, required this.id, required this.image, required this.price}) : super(key: key);

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
      getSameProducts = ProductsService().getProducts(parametrs: {'category_id': value.mainCategoryId.toString()});
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kBlackColor,
        appBar: productProfilAppBar(widget.name, widget.image, widget.price),
        body: FutureBuilder<ProductByIDModel>(
            future: productProfil,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(color: Colors.white, child: Center(child: spinKit()));
              } else if (snapshot.data == null) {
                return Text("Empty");
              } else if (snapshot.hasError) {
                return Text("Error");
              }
              return Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                        ),
                        child: ListView(
                          children: [
                            productProfilImagePart(snapshot.data!.images!),
                            productProfilNamePricePart(name: snapshot.data!.name!, price: snapshot.data!.price!, barCode: snapshot.data!.barcode.toString()),
                            productProfildescriptionPart(brand: snapshot.data!.producerName!, category: snapshot.data!.mainCategoryName!, createdAt: snapshot.data!.createdAt!.substring(0, 10), description: snapshot.data!.description!, viewCount: snapshot.data!.viewCount!.toString()),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                bottom: snapshot.data!.colors!.isEmpty && snapshot.data!.sizes!.isEmpty ? 0 : 35,
                              ),
                              child: Column(
                                children: [
                                  snapshot.data!.colors!.isEmpty ? SizedBox.shrink() : chooseColor(size, snapshot.data!.colors!),
                                  snapshot.data!.sizes!.isEmpty ? SizedBox.shrink() : chooseSize(size, snapshot.data!.sizes!),
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
            }));
  }

  Column chooseColor(Size size, List<ColorModel> colorss) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listViewName("chooseTheColor", false, size, () {}),
        Container(
          height: 90,
          margin: EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: colorss.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              String code = colorss[index].color!.substring(1, 7);
              String codeII = "0xff$code";
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(color: Color(int.parse(codeII)), borderRadius: borderRadius15, border: Border.all(color: kPrimaryColor, width: selectedColor == index ? 4 : 0)),
                      ),
                      Text(
                        colorss[index].name.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroyMedium),
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
        listViewName("chooseTheSize", false, size, () {}),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: ListView.builder(
            itemCount: sizes.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
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
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(borderRadius: borderRadius15, border: Border.all(color: selectedSize == index ? kPrimaryColor : Colors.grey.withOpacity(0.8), width: selectedSize == index ? 3 : 1)),
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
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular, fontSize: 16),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.price,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: gilroyBold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 6),
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
          Expanded(
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
