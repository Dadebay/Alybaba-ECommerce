// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/cards/category_card.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/category_model.dart';
import '../../home/controllers/home_controller.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBAr(context),
      body: FutureBuilder<List<CategoryModel>>(
        future: homeController.category,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (snapshot.hasError) {
            return referalPageEmptyData();
          } else if (snapshot.data!.isEmpty) {
            return referalPageError();
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemExtent: size.width >= 800 ? 320 : 220,
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return CategoryCard(
                subCategoryList: snapshot.data![index].subCategory!,
                id: snapshot.data![index].id!,
                image: '$serverURL/${snapshot.data![index].image!}-mini.webp',
                name: snapshot.data![index].name!,
              );
            },
          );
        },
      ),
    );
  }

  TextEditingController textEditingController = TextEditingController();
  AppBar appBAr(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorController.findMainColor.value == 0
            ? kPrimaryColor
            : colorController.findMainColor.value == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
      ),
      leadingWidth: 0.0,
      titleSpacing: 0.0,
      shadowColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      foregroundColor: colorController.findMainColor.value == 0
          ? kPrimaryColor
          : colorController.findMainColor.value == 1
              ? kPrimaryColor1
              : kPrimaryColor2,
      scrolledUnderElevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      title: Container(
        width: Get.size.width,
        child: searchField(textEditingController, context),
      ),
    );
  }
}
