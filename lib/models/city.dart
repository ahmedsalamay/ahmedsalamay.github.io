import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.name,
    required this.regions,
  });

  final String name;
  final List<Region> regions;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["nameEn"],
        regions:
            List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nameEn": name,
        "regions": List<dynamic>.from(regions.map((x) => x.toJson())),
      };
}

class Region {
  Region({
    required this.name,
  });

  final String name;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        name: json["nameEn"] == null ? null : json["nameEn"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
