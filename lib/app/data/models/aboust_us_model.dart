class AboutUsModel {
  final String? phone1;
  final String? phone2;
  final String? address;
  final String? email;
  AboutUsModel({
    this.phone1,
    this.phone2,
    this.address,
    this.email,
  });

  factory AboutUsModel.fromJson(Map<dynamic, dynamic> json) {
    return AboutUsModel(
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
