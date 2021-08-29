import 'dart:convert';

List<Walls> wallsFromJson(String str) =>
    List<Walls>.from(json.decode(str).map((x) => Walls.fromJson(x)));

String wallsToJson(List<Walls> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Walls {
  Walls({
    required this.noImage,
    required this.areaWidth,
    required this.areaHeight,
    required this.imgWidth,
    required this.imgHeight,
    required this.wallName,
    required this.imagesType,
    required this.images,
  });

  final int noImage;
  final int areaWidth;
  final int areaHeight;
  final int imgWidth;
  final int imgHeight;
  final String wallName;
  final String imagesType;
  final List<ImageOffset> images;

  factory Walls.fromJson(Map<String, dynamic> json) => Walls(
        noImage: json["no_image"],
        areaWidth: json["areaWidth"],
        areaHeight: json["areaHeight"],
        imgWidth: json["imgWidth"],
        imgHeight: json["imgHeight"],
        wallName: json["wallname"],
        imagesType: json["imagesType"],
        images: List<ImageOffset>.from(
            json["images"].map((x) => ImageOffset.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "no_image": noImage,
        "areaWidth": areaWidth,
        "areaHeight": areaHeight,
        "imgWidth": imgWidth,
        "imgHeight": imgHeight,
        "wallname": wallName,
        "imagesType": imagesType,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImageOffset {
  ImageOffset({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  factory ImageOffset.fromJson(Map<String, dynamic> json) => ImageOffset(
        x: json["x"],
        y: json["y"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
