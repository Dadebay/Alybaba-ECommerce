class ReferalModel {
  final String? fullName;
  final String? date;
  final String? sum;
  ReferalModel({
    this.fullName,
    this.date,
    this.sum,
  });

  factory ReferalModel.fromJson(Map<dynamic, dynamic> json) {
    return ReferalModel(
      fullName: json['full_name'] ?? '',
      date: json['registered_date'] ?? '',
      sum: json['sum'].toString(),
    );
  }
}
