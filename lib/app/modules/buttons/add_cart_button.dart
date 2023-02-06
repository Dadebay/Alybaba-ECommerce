import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/models/product_model.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/controllers/cart_page_controller.dart';

import '../../constants/widgets.dart';

class AddCartButton extends StatefulWidget {
  const AddCartButton({
    Key? key,
    required this.id,
    required this.productProfil,
  }) : super(key: key);

  final int id;
  final bool productProfil;

  @override
  State<AddCartButton> createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<AddCartButton> {
  bool addCartBool = false;
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
        ProductsService().getProductByID(widget.id).then((value) {
          addCartBool = !addCartBool;
          if (value.sizes!.isEmpty && value.colors!.isEmpty) {
            cartController.addToCard(id: widget.id, name: value.name!, image: "$serverURL/${value.images![0]['destination']}-big.webp", createdAt: value.createdAt!, price: value.price!, sizeID: 0, colorID: 0, airplane: value.airPlane!);
            showSnackBar('added', 'addedSubtitle', kPrimaryColor);
          } else {
            int sizeId = 0;
            int colorId = 0;
            if (value.sizes!.isEmpty) {
              colorEmptyOnlySize(value, colorId, sizeId);
            } else if (value.sizes!.isEmpty) {
              sizeEmptyOnlyColor(value, sizeId, colorId);
            } else {
              sizeColorNotEmpty(value, sizeId, colorId);
            }
          }
          setState(() {});
        });
      },
      child: Container(
        width: widget.productProfil ? null : Get.size.width,
        margin: EdgeInsets.only(
          top: 4,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: widget.productProfil ? 8 : 4),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: widget.productProfil ? borderRadius10 : borderRadius5,
        ),
        child: widget.productProfil
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2, right: 8, left: 2),
                    child: Icon(
                      IconlyBroken.bag,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'addCart'.tr,
                    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
                  ),
                ],
              )
            : Text('addCart'.tr, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 16)),
      ),
    );
  }

  void colorEmptyOnlySize(ProductByIDModel value, int colorId, int sizeId) {
    Get.defaultDialog(
        title: 'selectSize'.tr,
        titleStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
        content: Column(
            children: List.generate(
                value.colors!.length,
                (index) => ElevatedButton(
                    onPressed: () {
                      colorId = value.colors![index].id!;
                      cartController.addToCard(id: widget.id, name: value.name!, image: "$serverURL/${value.images![0]['destination']}-big.webp", createdAt: value.createdAt!, price: value.price!, sizeID: sizeId, colorID: colorId, airplane: value.airPlane!);
                      showSnackBar('added', 'addedSubtitle', kPrimaryColor);
                      Get.back();
                    },
                    child: Text(value.colors![index].name!)))));
  }

  void sizeEmptyOnlyColor(ProductByIDModel value, int sizeId, int colorId) {
    Get.defaultDialog(
        title: 'selectColor'.tr,
        titleStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
        content: Column(
            children: List.generate(
                value.sizes!.length,
                (index) => ElevatedButton(
                    onPressed: () {
                      sizeId = value.sizes![index].id!;
                      cartController.addToCard(id: widget.id, name: value.name!, image: "$serverURL/${value.images![0]['destination']}-big.webp", createdAt: value.createdAt!, price: value.price!, sizeID: sizeId, colorID: colorId, airplane: value.airPlane!);
                      showSnackBar('added', 'addedSubtitle', kPrimaryColor);
                      Get.back();
                    },
                    child: Text(value.sizes![index].name!)))));
  }

  void sizeColorNotEmpty(ProductByIDModel value, int sizeId, int colorId) {
    Get.defaultDialog(
        title: 'selectSize'.tr,
        titleStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
        content: Column(
            children: List.generate(
                value.sizes!.length,
                (index) => ElevatedButton(
                    onPressed: () {
                      sizeId = value.sizes![index].id!;
                      Get.back();
                      Get.defaultDialog(
                          title: 'selectColor'.tr,
                          titleStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                          content: Column(
                              children: List.generate(
                                  value.colors!.length,
                                  (index) => ElevatedButton(
                                      onPressed: () {
                                        colorId = value.colors![index].id!;
                                        cartController.addToCard(id: widget.id, name: value.name!, image: "$serverURL/${value.images![0]['destination']}-big.webp", createdAt: value.createdAt!, price: value.price!, sizeID: sizeId, colorID: colorId, airplane: value.airPlane!);
                                        showSnackBar('added', 'addedSubtitle', kPrimaryColor);
                                        Get.back();
                                      },
                                      child: Text(value.colors![index].name!)))));
                    },
                    child: Text(value.sizes![index].name!))))).then((value2) {});
  }

  Container numberPart() {
    return Container(
      margin: widget.productProfil ? EdgeInsets.only(left: 8, right: 8) : EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: widget.productProfil ? borderRadius10 : BorderRadius.circular(0),
        color: widget.productProfil ? Colors.transparent : Colors.transparent,
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
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
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
              padding: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(color: widget.productProfil ? Colors.white : kPrimaryColor.withOpacity(0.1), borderRadius: borderRadius5),
              child: Text(
                '${quantity}',
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.productProfil ? kPrimaryColor : Colors.black, fontFamily: gilroyBold, fontSize: 20),
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
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
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
