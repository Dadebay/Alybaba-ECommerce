class ProductModel {
  final int? id;
  final String? name;
  final String? price;
  final String? mainCategoryName;
  final String? subCategoryName;
  final String? producerName;
  final String? createdAt;
  final bool? newInCome;
  final bool? airplane;
  final bool? recomended;
  final bool? onHand;
  final bool? kargoIncluded;
  final String? image;
  final int? discountId;
  final int? discountValue;
  final int? discountValueType;
  final List<SizeModel>? sizes;

  final List<ColorModel>? colors;

  ProductModel({this.id, this.airplane, this.name, this.price, this.kargoIncluded, this.createdAt, this.mainCategoryName, this.subCategoryName, this.producerName, this.newInCome, this.recomended, this.onHand, this.image, this.discountId, this.discountValue, this.discountValueType, this.sizes, this.colors});

  factory ProductModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? 'Ady',
      price: json['price'] ?? 'Bahasy',
      airplane: json['airplane'] ?? true,
      createdAt: json['created_at'] ?? 'sene',
      mainCategoryName: json['main_category_name'] ?? '',
      subCategoryName: json['sub_category_name'] ?? '',
      producerName: json['producer_name'] ?? '',
      newInCome: json['new_in_come'] ?? false,
      recomended: json['recomended'] ?? false,
      onHand: json['on_hand'] ?? false,
      kargoIncluded: json['kargo_included'] ?? false,
      image: json['image'] ?? '',
      discountId: json['discount_id'] ?? 0,
      discountValue: json['discount_value'] ?? 0,
      discountValueType: json['discount_value_type'] ?? 0,
      sizes: json['sizes'] != null ? (json['sizes'] as List).map((json) => SizeModel.fromJson(json)).toList() : [],
      colors: json['colors'] != null ? (json['colors'] as List).map((json) => ColorModel.fromJson(json)).toList() : [],
    );
  }
}

class ProductByIDModel {
  final int? id;
  final bool? airPlane;
  final String? name;
  final String? description;
  final String? price;
  final String? mainCategoryName;
  final String? subCategoryName;
  final String? producerName;
  final bool? newInCome;
  final bool? recomended;
  final int? subCategoryId;
  final int? mainCategoryId;
  final int? producerId;
  final bool? onHand;
  final String? barcode;
  final bool? kargoIncluded;

  final int? viewCount;
  final String? createdAt;
  final List? images;
  final List<SizeModel>? sizes;
  final List<ColorModel>? colors;
  ProductByIDModel({this.id, this.sizes, this.name, this.kargoIncluded, this.price, this.viewCount, this.createdAt, this.barcode, this.mainCategoryName, this.subCategoryName, this.producerName, this.newInCome, this.recomended, this.onHand, this.images, this.airPlane, this.description, this.colors, this.mainCategoryId, this.producerId, this.subCategoryId});

  factory ProductByIDModel.fromJson(Map<dynamic, dynamic> json) {
    final List image = json['images'] as List;
    List<dynamic> images = [];
    if (image == null) {
      images = [''];
    } else {
      images = image.map((value) => value).toList();
    }
    return ProductByIDModel(
      id: json['id'],
      airPlane: json['airplane'] ?? false,
      name: json['name'],
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      kargoIncluded: json['kargo_included'] ?? false,
      mainCategoryName: json['main_category_name'] ?? '',
      subCategoryName: json['sub_category_name'] ?? ' ',
      producerName: json['producer_name'] ?? '',
      newInCome: json['new_in_come'] ?? false,
      recomended: json['recomended'] ?? false,
      subCategoryId: json['sub_category_id'],
      mainCategoryId: json['main_category_id'],
      producerId: json['producer_id'],
      onHand: json['on_hand'] ?? false,
      barcode: json['barcode'] ?? '#000000',
      viewCount: json['view_count'] ?? '1',
      createdAt: json['created_at'] ?? '#000000',
      images: images,
      sizes: json['sizes'] != null ? (json['sizes'] as List).map((json) => SizeModel.fromJson(json)).toList() : [],
      colors: json['colors'] != null ? (json['colors'] as List).map((json) => ColorModel.fromJson(json)).toList() : [],
    );
  }
}

class ColorModel {
  String? color;
  String? name;
  int? id;

  ColorModel({this.name, this.color, this.id});

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      color: json['color'],
      name: json['name'],
      id: json['id'],
    );
  }
}

class SizeModel {
  String? name;
  int? id;

  SizeModel({this.name, this.id});

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      name: json['size'],
      id: json['id'],
    );
  }
}
