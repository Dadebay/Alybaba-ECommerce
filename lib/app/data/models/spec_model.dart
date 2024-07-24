import 'package:nabelli_ecommerce/app/data/models/product_model.dart';

class GetCatSpecsModel {
  final List? sizes;
  final List<ColorModel>? colors;
  final List<SpecsModel>? specs;
  GetCatSpecsModel({this.sizes, this.colors, this.specs});

  factory GetCatSpecsModel.fromJson(Map<dynamic, dynamic> json) {
    return GetCatSpecsModel(
      sizes: json['sizes'] ?? 'Aman',
      colors: json['colors'] != null ? (json['colors'] as List).map((json) => ColorModel.fromJson(json)).toList() : [],
      specs: json['specs'] != null ? (json['specs'] as List).map((json) => SpecsModel.fromJson(json)).toList() : [],
    );
  }
}

class SpecsModel {
  String? name;
  int? id;
  final List<ValuesModel>? values;

  SpecsModel({this.name, this.id, this.values});

  factory SpecsModel.fromJson(Map<String, dynamic> json) {
    return SpecsModel(
      name: json['name'],
      id: json['spec_id'],
      values: json['values'] != null ? (json['values'] as List).map((json) => ValuesModel.fromJson(json)).toList() : [],
    );
  }
}

class ValuesModel {
  String? valueName;
  int? valueID;

  ValuesModel({this.valueName, this.valueID});

  factory ValuesModel.fromJson(Map<String, dynamic> json) {
    return ValuesModel(
      valueName: json['value_name'],
      valueID: json['value_id'],
    );
  }
}
