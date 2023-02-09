// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/models/category_model.dart';

import '../../other_pages/show_all_products.dart';

class SubCategoryView extends StatefulWidget {
  const SubCategoryView({Key? key, required this.subCategoryList, required this.categoryID}) : super(key: key);
  final List<SubCategoryModel> subCategoryList;
  final int categoryID;
  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Sub category Name".tr),
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 24),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemExtent: 220,
        itemCount: widget.subCategoryList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => ShowAllProducts(
                    filter: true,
                    pageName: widget.subCategoryList[index].name.toString(),
                    parametrs: {'sub_category_id': '${widget.subCategoryList[index].id}', 'main_category_id': widget.categoryID.toString()},
                  ));
            },
            child: Container(
              child: Text(widget.subCategoryList[index].name.toString()),
              margin: EdgeInsets.all(8),
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
