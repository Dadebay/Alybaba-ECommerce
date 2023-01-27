class GetOrderInfoModel {
  final String? info;
  final List<TransportModel>? transports;
  GetOrderInfoModel({
    this.info,
    this.transports,
  });

  factory GetOrderInfoModel.fromJson(Map<dynamic, dynamic> json) {
    return GetOrderInfoModel(
      transports: json['transports'] != null ? (json['transports'] as List).map((json) => TransportModel.fromJson(json)).toList() : [],
      info: json['info'] ?? '',
    );
  }
}

class TransportModel {
  int? minWeek;
  int? maxWeek;
  int? transport;

  TransportModel({this.minWeek, this.maxWeek, this.transport});

  factory TransportModel.fromJson(Map<String, dynamic> json) {
    return TransportModel(
      minWeek: json['min_week'],
      maxWeek: json['max_week'],
      transport: json['transport'],
    );
  }
}
