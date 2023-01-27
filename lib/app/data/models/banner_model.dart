class BannerModel {
  final int? id;
  final int? pathId;
  final int? itemId;
  final int? placeId;
  final String? destination;
  final String? titleRU;
  final String? titleTM;
  final String? descriptionTM;
  final String? descriptionRU;
  BannerModel({
    this.id,
    this.destination,
    this.pathId,
    this.itemId,
    this.placeId,
    this.titleRU,
    this.titleTM,
    this.descriptionRU,
    this.descriptionTM,
  });

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      titleTM: json['title_tm'] ?? '',
      titleRU: json['title_ru'] ?? '',
      descriptionTM: json['description_tm'] ?? '',
      descriptionRU: json['description_ru'] ?? '',
      destination: json['destination'] ?? '',
      pathId: json['path_id'] ?? 0,
      itemId: json['item_id'] ?? 0,
      placeId: json['place_id'] ?? 0,
    );
  }
}
