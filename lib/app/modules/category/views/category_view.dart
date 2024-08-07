// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:nabelli_ecommerce/app/constants/cards/category_card.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/services/category_service.dart';

import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../../data/models/category_model.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<CategoryModel>>(
      future: CategoryService().getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return spinKit();
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
    );
  }
}
