import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';

import '../widgets.dart';

class AddCartButton extends StatefulWidget {
  const AddCartButton({
    required this.id,
    required this.productProfil,
    Key? key,
  }) : super(key: key);

  final int id;
  final bool productProfil;

  @override
  State<AddCartButton> createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<AddCartButton> {
  bool addCartBool = false;
  bool agreeButtonLoading = false;
  int quantity = 1;

  final CartPageController cartController = Get.put(CartPageController());
  @override
  void initState() {
    super.initState();
    changeCartCount2();
  }

  dynamic changeCartCount2() {
    addCartBool = false;
    for (final element in cartController.list) {
      if (element['id'] == widget.id) {
        addCartBool = true;
        quantity = element['quantity'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      changeCartCount2();
      return addCartBool ? numberPart() : buttonPart();
    });
  }

  GestureDetector buttonPart() {
    return GestureDetector(
      onTap: () {
        agreeButtonLoading = !agreeButtonLoading;
        // setState(() {});
        if (agreeButtonLoading == true) {
          ProductsService().getProductByID(widget.id).then((value) {
            addCartBool = !addCartBool;
            if (value.sizes!.isEmpty && value.colors!.isEmpty) {
              cartController.addToCard(
                id: widget.id,
                name: value.name!,
                image: "$serverURL/${value.images!.first['destination']}-mini.webp",
                createdAt: value.createdAt!,
                price: value.price!,
                sizeID: 0,
                colorID: 0,
                airplane: value.airPlane!,
              );
              agreeButtonLoading = false;

              showSnackBar(
                'added',
                'addedSubtitle',
                colorController.mainColor,
              );
            } else {
              if (value.sizes!.isEmpty) {
                onlyColorsSelect(value);
              } else if (value.colors!.isEmpty) {
                onlySizesSelect(value);
              } else {
                sizeAndColorSelect(value);
              }
              agreeButtonLoading = false;
            }
          });
        } else {
          showSnackBar('waitMyMan', 'waitMyManSubtitle', Colors.red);
        }
        setState(() {});
      },
      child: Container(
        width: widget.productProfil ? null : Get.size.width,
        margin: const EdgeInsets.only(
          top: 4,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: widget.productProfil ? 8 : 4),
        decoration: BoxDecoration(
          color: colorController.mainColor,
          borderRadius: widget.productProfil ? borderRadius10 : borderRadius5,
        ),
        child: widget.productProfil
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 2, right: 8),
                    child: Icon(
                      IconlyBroken.bag,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'addCart'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 18),
                  ),
                ],
              )
            : agreeButtonLoading
                ? Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text('addCart'.tr, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 16)),
      ),
    );
  }

  void onlyColorsSelect(ProductByIDModel value) {
    Get.defaultDialog(
      title: 'selectColor'.tr,
      titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 35),
      radius: 5,
      content: Column(
        children: List.generate(
          value.colors!.length,
          (index) => SizedBox(
            width: Get.size.width,
            child: ElevatedButton(
              onPressed: () {
                cartController.addToCard(
                  id: widget.id,
                  name: value.name!,
                  image: "$serverURL/${value.images!.first['destination']}-mini.webp",
                  createdAt: value.createdAt!,
                  price: value.price!,
                  sizeID: 0,
                  colorID: value.colors![index].id!,
                  airplane: value.airPlane!,
                );
                Get.back();
                showSnackBar(
                  'added',
                  'addedSubtitle',
                  colorController.mainColor,
                );
              },
              style: ElevatedButton.styleFrom(elevation: 0.6, shape: const RoundedRectangleBorder(borderRadius: borderRadius5)),
              child: Text(
                value.colors![index].name!,
                style: TextStyle(
                  color: colorController.mainColor,
                  fontFamily: gilroySemiBold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onlySizesSelect(ProductByIDModel value) {
    Get.defaultDialog(
      title: 'selectSize'.tr,
      titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 35),
      radius: 5,
      content: Column(
        children: List.generate(
          value.sizes!.length,
          (index) => SizedBox(
            width: Get.size.width,
            child: ElevatedButton(
              onPressed: () {
                cartController.addToCard(
                  id: widget.id,
                  name: value.name!,
                  image: "$serverURL/${value.images!.first['destination']}-mini.webp",
                  createdAt: value.createdAt!,
                  price: value.price!,
                  sizeID: value.sizes![index].id!,
                  colorID: 0,
                  airplane: value.airPlane!,
                );
                Get.back();

                showSnackBar(
                  'added',
                  'addedSubtitle',
                  colorController.mainColor,
                );
              },
              style: ElevatedButton.styleFrom(elevation: 0.6, shape: const RoundedRectangleBorder(borderRadius: borderRadius5)),
              child: Text(
                value.sizes![index].name!,
                style: TextStyle(
                  color: colorController.mainColor,
                  fontFamily: gilroySemiBold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sizeAndColorSelect(ProductByIDModel value) {
    Get.defaultDialog(
      title: 'selectSize'.tr,
      titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 35),
      radius: 5,
      content: Column(
        children: List.generate(
          value.sizes!.length,
          (indexx) => SizedBox(
            width: Get.size.width,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.defaultDialog(
                  title: 'selectColor'.tr,
                  titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                  radius: 5,
                  content: Column(
                    children: List.generate(
                      value.colors!.length,
                      (index) => SizedBox(
                        width: Get.size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            cartController.addToCard(
                              id: widget.id,
                              name: value.name!,
                              image: "$serverURL/${value.images!.first['destination']}-mini.webp",
                              createdAt: value.createdAt!,
                              price: value.price!,
                              sizeID: value.sizes![indexx].id!,
                              colorID: value.colors![index].id!,
                              airplane: value.airPlane!,
                            );
                            Get.back();
                            showSnackBar(
                              'added',
                              'addedSubtitle',
                              colorController.mainColor,
                            );
                          },
                          style: ElevatedButton.styleFrom(elevation: 0.6, shape: const RoundedRectangleBorder(borderRadius: borderRadius5)),
                          child: Text(
                            value.colors![index].name!,
                            style: TextStyle(
                              color: colorController.mainColor,
                              fontFamily: gilroySemiBold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(elevation: 0.6, shape: const RoundedRectangleBorder(borderRadius: borderRadius5)),
              child: Text(
                value.sizes![indexx].name!,
                style: TextStyle(
                  color: colorController.mainColor,
                  fontFamily: gilroySemiBold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container numberPart() {
    return Container(
      margin: widget.productProfil ? const EdgeInsets.only(left: 8, right: 8) : EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: widget.productProfil ? borderRadius10 : BorderRadius.circular(0),
        color: Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                quantity--;
                if (quantity == 0) {
                  quantity = 1;
                  addCartBool = false;
                }

                cartController.minusCardElement(widget.id);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: colorController.mainColor,
                  borderRadius: borderRadius10,
                ),
                child: Icon(CupertinoIcons.minus, color: Colors.white, size: widget.productProfil ? 24 : 20),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(color: widget.productProfil ? Colors.white : colorController.mainColor.withOpacity(0.1), borderRadius: borderRadius5),
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.productProfil ? colorController.mainColor : Colors.black,
                  fontFamily: gilroyBold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                quantity++;
                cartController.updateCartQuantity(widget.id);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: colorController.mainColor,
                  borderRadius: borderRadius10,
                ),
                child: Icon(CupertinoIcons.add, color: Colors.white, size: widget.productProfil ? 24 : 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
