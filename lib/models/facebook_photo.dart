// ignore: prefer_if_null_operators

import 'dart:convert';

PhotoPaging photoPagingFromJson(String str) =>
    PhotoPaging.fromJson(json.decode(str));

String photoPagingToJson(PhotoPaging data) => json.encode(data.toJson());

class PhotoPaging {
  PhotoPaging({
    required this.data,
    required this.paging,
  });

  final List<FaceBookPhoto>? data;
  final Paging? paging;

  factory PhotoPaging.fromJson(Map<String, dynamic> json) => PhotoPaging(
        data: json["data"] == null
            ? null
            : List<FaceBookPhoto>.from(
                json["data"].map((x) => FaceBookPhoto.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "paging": paging == null ? null : paging!.toJson(),
      };
}

class FaceBookPhoto {
  FaceBookPhoto({
    required this.id,
    required this.width,
    required this.height,
    required this.source,
    required this.name,
  });

  final String id;
  final int width;
  final int height;
  final String source;
  final String? name;

  factory FaceBookPhoto.fromJson(Map<String, dynamic> json) => FaceBookPhoto(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        source: json["source"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "source": source,
        "name": name,
      };
}

class Paging {
  Paging({
    required this.cursors,
  });

  final Cursors? cursors;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        cursors:
            json["cursors"] == null ? null : Cursors.fromJson(json["cursors"]),
      );

  Map<String, dynamic> toJson() => {
        "cursors": cursors == null ? null : cursors!.toJson(),
      };
}

class Cursors {
  Cursors({
    required this.before,
    required this.after,
  });

  final String before;
  final String after;

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
        before: json["before"],
        after: json["after"],
      );

  Map<String, dynamic> toJson() => {
        "before": before,
        "after": after,
      };
}
