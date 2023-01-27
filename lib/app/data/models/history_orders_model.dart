class HistoryOrdersModel {
  final int? id;
  final int? transport;
  final String? total;
  final String? createdAt;
  final String? statusText;
  HistoryOrdersModel({this.id, this.transport, this.total, this.createdAt, this.statusText});

  factory HistoryOrdersModel.fromJson(Map<dynamic, dynamic> json) {
    return HistoryOrdersModel(
      id: json['id'],
      transport: json['transport'],
      total: json['total'],
      createdAt: json['created_at'],
      statusText: json['status_text'],
    );
  }
}
