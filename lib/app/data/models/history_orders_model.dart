class HistoryOrdersModel {
  final int? id;
  final int? statusId;
  final int? transport;
  final String? total;
  final String? createdAt;
  final String? statusText;
  final List? items;
  HistoryOrdersModel({this.id, this.statusId, this.items, this.transport, this.total, this.createdAt, this.statusText});

  factory HistoryOrdersModel.fromJson(Map<dynamic, dynamic> json) {
    return HistoryOrdersModel(
      id: json['id'],
      transport: json['transport'] ?? 1,
      total: json['total'] ?? 'Null',
      createdAt: json['created_at'] ?? '0',
      items: json['items'] ?? [],
      statusId: json['status_id'] ?? [],
      statusText: json['status_text'] ?? 'Null',
    );
  }
}

class HistoryOrdersModelByID {
  final int? id;
  final int? statusId;
  final int? transport;
  final String? total;
  final String? createdAt;
  final String? statusText;
  final List<HistoryProducts>? items;
  HistoryOrdersModelByID({this.id, this.statusId, this.items, this.transport, this.total, this.createdAt, this.statusText});

  factory HistoryOrdersModelByID.fromJson(Map<dynamic, dynamic> json) {
    return HistoryOrdersModelByID(
      id: json['id'],
      transport: json['transport'] ?? 1,
      total: json['total'] ?? 'Null',
      createdAt: json['created_at'] ?? '0',
      items: (json['items'] as List).map((json) => HistoryProducts.fromJson(json)).toList(),
      statusId: json['status_id'] ?? [],
      statusText: json['status_text'] ?? 'Null',
    );
  }
}

class HistoryProducts {
  String? price;
  String? name;
  String? color;
  String? barcode;
  String? image;
  int? id;

  HistoryProducts({this.name, this.price, this.id, this.barcode, this.color, this.image});

  factory HistoryProducts.fromJson(Map<String, dynamic> json) {
    return HistoryProducts(
      price: json['price'],
      barcode: json['barcode'],
      image: json['image'],
      color: json['color'],
      name: json['name'],
      id: json['id'],
    );
  }
}
