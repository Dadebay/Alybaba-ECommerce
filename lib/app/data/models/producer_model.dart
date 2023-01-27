class ProducersModel {
  final int? id;
  final String? name;
  final String? image;
  ProducersModel({
    this.id,
    this.name,
    this.image,
  });

  factory ProducersModel.fromJson(Map<dynamic, dynamic> json) {
    return ProducersModel(
      id: json['id'],
      name: json['name'] ?? 'Aman',
      image: json['destination'] ?? 'Aman',
    );
  }
}
