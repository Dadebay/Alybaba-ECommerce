class CategoryModel {
  final int? id;
  final String? name;
  final String? image;
  CategoryModel({
    this.id,
    this.name,
    this.image,
  });

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? 'Aman',
      image: json['destination'] ?? 'Aman',
    );
  }
}
