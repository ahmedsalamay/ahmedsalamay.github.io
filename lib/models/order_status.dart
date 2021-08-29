import 'dart:convert';

List<OrderStatus> orderStatusFromJson(String str) => List<OrderStatus>.from(
    json.decode(str).map((x) => OrderStatus.fromJson(x)));

String orderStatusToJson(List<OrderStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderStatus {
  OrderStatus({
    required this.name,
    required this.phone,
    required this.paid,
    required this.status,
    required this.total,
  });

  final String name;
  final String phone;
  final bool paid;
  final int status;
  final double total;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        paid: json["paid"] == null ? null : json["paid"],
        status: json["status"] == null ? null : json["status"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "paid": paid,
        "status": status,
        "total": total,
      };
}
