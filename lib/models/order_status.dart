import 'dart:convert';

List<OrderStatus> orderStatusFromJson(String str) => List<OrderStatus>.from(
    json.decode(str).map((x) => OrderStatus.fromJson(x)));

String orderStatusToJson(List<OrderStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderStatus {
  OrderStatus({
    required this.name,
    required this.phone,
    required this.email,
    required this.city,
    required this.region,
    required this.address,
    required this.buildingNo,
    required this.floor,
    required this.paymentMethod,
    required this.frame,
    required this.imageNo,
    required this.wallName,
    required this.typeofOrder,
    required this.giftText,
    required this.deliveryDate,
    required this.paid,
    required this.status,
    required this.total,
  });

  final String name;
  final String phone;
  final String email;
  final String city;
  final String region;
  final String address;
  final String buildingNo;
  final String floor;
  final String paymentMethod;
  final dynamic frame;
  final int imageNo;
  final String wallName;
  final String typeofOrder;
  final String giftText;
  final DateTime deliveryDate;
  final bool paid;
  final int status;
  final int total;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        city: json["city"] == null ? null : json["city"],
        region: json["region"] == null ? null : json["region"],
        address: json["address"] == null ? null : json["address"],
        buildingNo: json["buildingNo"] == null ? null : json["buildingNo"],
        floor: json["floor"] == null ? null : json["floor"],
        deliveryDate:
            json["deliverydate"] == null ? null : json["deliverydate"],
        paymentMethod: json["paymentmethod"],
        frame: json["frame"],
        imageNo: json["imageNo"] == null ? null : json["imageNo"],
        wallName: json["wallname"],
        typeofOrder: json["typeofOrder"] == null ? null : json["typeofOrder"],
        giftText: json["gifttext"],
        paid: json["paid"] == null ? null : json["paid"],
        status: json["status"] == null ? null : json["status"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "city": city == null ? null : city,
        "region": region == null ? null : region,
        "address": address == null ? null : address,
        "buildingNo": buildingNo == null ? null : buildingNo,
        "floor": floor == null ? null : floor,
        "paymentmethod": paymentMethod,
        "frame": frame,
        "imageNo": imageNo == null ? null : imageNo,
        "wallname": wallName,
        "typeofOrder": typeofOrder == null ? null : typeofOrder,
        "gifttext": giftText,
        "deliverydate":
            deliveryDate == null ? null : deliveryDate.toIso8601String(),
        "paid": paid == null ? null : paid,
        "status": status == null ? null : status,
        "total": total == null ? null : total,
      };
}
