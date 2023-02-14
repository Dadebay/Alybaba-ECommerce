// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/data/models/category_model.dart';

import '../../other_pages/show_all_products.dart';

class SubCategoryView extends StatelessWidget {
  const SubCategoryView({ required this.subCategoryList, required this.categoryID, required this.categoryName,Key? key,}) : super(key: key);
  final List<SubCategoryModel> subCategoryList;
  final int categoryID;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: categoryName),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: subCategoryList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Get.to(() => ShowAllProducts(
                    filter: true,
                    pageName: subCategoryList[index].name.toString(),
                    parametrs: {'sub_category_id': '${subCategoryList[index].id}', 'main_category_id': categoryID.toString()},
                  ),);
            },
            trailing: const Icon(
              IconlyLight.arrowRightCircle,
              color: Colors.black,
            ),
            title: Text(
              subCategoryList[index].name.toString(),
              style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black12,
            thickness: 1,
          );
        },
      ),
    );
  }
}
