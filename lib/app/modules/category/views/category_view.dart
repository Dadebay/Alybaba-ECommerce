// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/cards/category_card.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
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
      appBar: CustomAppBar(backArrow: false, actionIcon: false, name: 'category'),
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
}
