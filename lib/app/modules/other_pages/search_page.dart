import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/services/product_service.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/shop_by_brand.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';

import '../../data/models/producer_model.dart';
import '../../data/services/producers_service.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  late Future<List<ProducersModel>> producersFuture;
  @override
  void initState() {
    super.initState();
    producersFuture = ProducersService().getProducers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchField(),
            SizedBox(
              height: 10,
            ),
            ShopByBrand(
              producers: producersFuture,
            ),
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: TextFormField(
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
        cursorColor: Colors.black,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'errorEmpty'.tr;
          }
          return null;
        },
        onEditingComplete: () {
          Get.to(() => ShowAllProducts(pageName: 'Gozleg', getData: ProductsService().getProducts(parametrs: {'search': controller.text})));
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontFamily: gilroyMedium),
          hintText: 'search'.tr,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Icon(
              IconlyLight.search,
              color: Colors.black,
            ),
          ),
          fillColor: backgroundColor,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey, fontFamily: gilroyMedium),
          contentPadding: const EdgeInsets.only(left: 25, top: 14, bottom: 14, right: 10),
          border: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: kPrimaryColor, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: kPrimaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
