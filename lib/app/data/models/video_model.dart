class VideosModel {
  final int? id;
  final String? title;
  final String? description;
  final String? poster;
  final String? videoURL;
  final List<Products>? products;
  VideosModel({this.id, this.title, this.description, this.poster, this.videoURL, this.products});

  factory VideosModel.fromJson(Map<dynamic, dynamic> json) {
    return VideosModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      poster: json['poster'] ?? '',
      videoURL: json['video'] ?? '',
      products: (json['products'] as List).map((json) => Products.fromJson(json)).toList(),
    );
  }
}

class Products {
  String? price;
  String? name;
  String? image;
  int? id;

  Products({this.name, this.price, this.image, this.id});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      price: json['price'],
      image: json['image'],
      name: json['name'],
      id: json['id'],
    );
  }
}
