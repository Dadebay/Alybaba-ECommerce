class CategoryModel {
  final int? id;
  final String? name;
  final String? image;
  final List<SubCategoryModel>? subCategory;
  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.subCategory,
  });

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? 'Aman',
      image: json['destination'] ?? 'Aman',
      subCategory: json['sub'] != null ? (json['sub'] as List).map((json) => SubCategoryModel.fromJson(json)).toList() : [],
    );
  }
}

class SubCategoryModel {
  final int? id;
  final String? name;
  SubCategoryModel({
    this.id,
    this.name,
  });

  factory SubCategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'] ?? 'Aman',
    );
  }
}
