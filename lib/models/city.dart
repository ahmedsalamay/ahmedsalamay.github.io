import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.nameEn,
    required this.nameAr,
    required this.regions,
  });

  final String nameEn;
  final String nameAr;
  final List<Region> regions;

  factory City.fromJson(Map<String, dynamic> json) => City(
        nameEn: json["nameEn"],
        nameAr: json["nameAr"],
        regions:
            List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nameEn": nameEn,
        "nameAr": nameAr,
        "regions": List<dynamic>.from(regions.map((x) => x.toJson())),
      };
}

class Region {
  Region({
    required this.nameEn,
    required this.nameAr,
  });

  final String nameEn;
  final String nameAr;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        nameAr: json["nameAr"] == null ? null : json["nameAr"],
      );

  Map<String, dynamic> toJson() => {
        "nameEn": nameEn,
        "nameAr": nameAr,
      };
}
