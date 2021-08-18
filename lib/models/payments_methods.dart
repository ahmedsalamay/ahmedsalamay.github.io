import 'dart:convert';

List<PaymentsMethods> paymentsMethodsFromJson(String str) =>
    List<PaymentsMethods>.from(
        json.decode(str).map((x) => PaymentsMethods.fromJson(x)));

String paymentsMethodsToJson(List<PaymentsMethods> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentsMethods {
  PaymentsMethods({
    required this.companyName,
    required this.phoneNumber,
    required this.image,
  });

  final String companyName;
  final String phoneNumber;
  final String image;

  factory PaymentsMethods.fromJson(Map<String, dynamic> json) =>
      PaymentsMethods(
        companyName: json["companyName"] == null ? null : json["companyName"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "phoneNumber": phoneNumber,
        "image": image,
      };
}
