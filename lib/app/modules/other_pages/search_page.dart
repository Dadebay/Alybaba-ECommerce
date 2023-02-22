import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/shop_by_brand.dart';
import 'package:nabelli_ecommerce/app/modules/other_pages/show_all_products.dart';

import '../../data/models/producer_model.dart';
import '../../data/services/producers_service.dart';
import '../home/controllers/color_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

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
            const SizedBox(
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

  final ColorController colorController = Get.put(ColorController());

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
          Get.to(() => ShowAllProducts(pageName: 'search', filter: false, parametrs: {'search': controller.text}));
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontFamily: gilroyMedium),
          hintText: 'search'.tr,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Icon(
              IconlyLight.search,
              color: Colors.black,
            ),
          ),
          fillColor: backgroundColor,
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey, fontFamily: gilroyMedium),
          contentPadding: const EdgeInsets.only(left: 25, top: 14, bottom: 14, right: 10),
          border: const OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(
              color: colorController.findMainColor.value == 0
                  ? kPrimaryColor
                  : colorController.findMainColor.value == 1
                      ? kPrimaryColor1
                      : kPrimaryColor2,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(
              color: colorController.findMainColor.value == 0
                  ? kPrimaryColor
                  : colorController.findMainColor.value == 1
                      ? kPrimaryColor1
                      : kPrimaryColor2,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
