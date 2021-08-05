import 'dart:convert';

AlbumPaging facebookAlbumsFromJson(String str) =>
    AlbumPaging.fromJson(json.decode(str));

String facebookAlbumsToJson(AlbumPaging data) => json.encode(data.toJson());

class AlbumPaging {
  AlbumPaging({
    required this.data,
    required this.paging,
  });

  final List<Album> data;
  final Paging paging;

  factory AlbumPaging.fromJson(Map<String, dynamic> json) => AlbumPaging(
        data: List<Album>.from(json["data"].map((x) => Album.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class Album {
  Album({
    required this.coverPhoto,
    required this.id,
    required this.name,
    required this.count,
  });

  final CoverPhoto? coverPhoto;
  final String id;
  final String name;
  final int count;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        coverPhoto: json["cover_photo"] != null
            ? CoverPhoto.fromJson(json["cover_photo"])
            : null,
        id: json["id"],
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "cover_photo": coverPhoto == null ? null : coverPhoto!.toJson(),
        "id": id,
        "name": name,
        "count": count,
      };
}

class CoverPhoto {
  CoverPhoto({
    required this.source,
    required this.id,
  });

  final String source;
  final String id;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
        source: json["source"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "source": source,
        "id": id,
      };
}

class Paging {
  Paging({required this.cursors, required this.next});

  final Cursors cursors;
  final String? next;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        next: json["next"] != null ? json["next"] : null,
        cursors: Cursors.fromJson(json["cursors"]),
      );

  Map<String, dynamic> toJson() => {
        "cursors": cursors.toJson(),
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
