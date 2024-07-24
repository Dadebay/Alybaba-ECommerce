class BannerModel {
  final int? id;
  final int? pathId;
  final int? itemId;
  final int? placeId;
  final String? destination;
  final String? titleTM;
  final String? descriptionTM;
  BannerModel({
    this.id,
    this.destination,
    this.pathId,
    this.itemId,
    this.placeId,
    this.titleTM,
    this.descriptionTM,
  });

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      titleTM: json['title'] ?? '',
      descriptionTM: json['description'] ?? '',
      destination: json['destination'] ?? '',
      pathId: json['path_id'] ?? 0,
      itemId: json['item_id'] ?? 0,
      placeId: json['place_id'] ?? 0,
    );
  }
}
