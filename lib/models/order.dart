import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.name,
    this.phone,
    this.email,
    this.city,
    this.region,
    this.address,
    this.buildingNo,
    this.floor,
    this.paymentMethod,
    this.frame,
    this.imageNo,
    this.wallName,
    this.typeofOrder,
    this.giftText,
    this.deliveryDate,
    this.images,
  });

  String? name;
  String? phone;
  String? email;
  String? city;
  String? region;
  String? address;
  String? buildingNo;
  String? floor;
  String? paymentMethod;
  String? frame;
  int? imageNo;
  String? wallName;
  String? typeofOrder;
  String? giftText;
  DateTime? deliveryDate;
  List<String>? images;
  PromoCode? promoCode;
  double? packagePrice;
  double? packageSize;
  double? extraImagePrice;
  double? deliveryFee;
  double total = 0;
  double discount = 0;

  void applyPromoCode(PromoCode value) {
    promoCode = value;
  }

  void calculateTotal() {
    total = packagePrice!;
    if (imageNo! > packageSize!)
      total += (imageNo! - packageSize!) * extraImagePrice!;
    if (promoCode != null) {
      discount = total * promoCode!.percentage;
      total -= discount;
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        city: json["city"] == null ? null : json["city"],
        region: json["region"] == null ? null : json["region"],
        address: json["address"] == null ? null : json["address"],
        buildingNo: json["buildingNo"] == null ? null : json["buildingNo"],
        floor: json["floor"] == null ? null : json["floor"],
        paymentMethod:
            json["paymentmethod"] == null ? null : json["paymentmethod"],
        frame: json["frame"] == null ? null : json["frame"],
        imageNo: json["imageNo"] == null ? null : json["imageNo"],
        wallName: json["wallname"] == null ? null : json["wallname"],
        typeofOrder: json["typeofOrder"] == null ? null : json["typeofOrder"],
        giftText: json["gifttext"] == null ? null : json["gifttext"],
        deliveryDate: json["deliverydate"] == null
            ? null
            : DateTime.parse(json["deliverydate"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
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
        "paymentmethod": paymentMethod == null ? null : paymentMethod,
        "frame": frame == null ? null : frame,
        "imageNo": imageNo == null ? null : imageNo,
        "wallname": wallName == null ? null : wallName,
        "typeofOrder": typeofOrder == null ? null : typeofOrder,
        "gifttext": giftText == null ? null : giftText,
        "promocode": promoCode != null ? promoCode!.code : null,
        "deliverydate":
            deliveryDate == null ? null : deliveryDate!.toIso8601String(),
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
      };
}

class PromoCode {
  final String code;
  final double percentage;
  final bool used;

  PromoCode(this.code, this.percentage, this.used);

  factory PromoCode.fromJson(String code, Map<String, dynamic> json) =>
      PromoCode(
        code,
        json['percent'],
        json['used'],
      );
}
