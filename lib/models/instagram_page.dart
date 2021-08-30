import 'dart:convert';

class InstagramPage {
  InstagramPage({
    required this.data,
    required this.paging,
  });

  final List<Data> data;
  final Paging paging;

  InstagramPage copyWith({
    required List<Data> data,
    required Paging paging,
  }) =>
      InstagramPage(
        data: data,
        paging: paging,
      );

  factory InstagramPage.fromRawJson(String str) =>
      InstagramPage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InstagramPage.fromJson(Map<String, dynamic> json) => InstagramPage(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.caption,
  });

  final String id;
  final String caption;

  Data copyWith({
    required String id,
    required String caption,
  }) =>
      Data(
        id: id,
        caption: caption,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        caption: json["caption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "caption": caption,
      };
}

class Paging {
  Paging({
    required this.cursors,
    required this.next,
  });

  final Cursors cursors;
  final String next;

  Paging copyWith({
    required Cursors cursors,
    required String next,
  }) =>
      Paging(
        cursors: cursors,
        next: next,
      );

  factory Paging.fromRawJson(String str) => Paging.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        cursors: Cursors.fromJson(json["cursors"]),
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "cursors": cursors,
        "next": next,
      };
}

class Cursors {
  Cursors({
    required this.after,
    required this.before,
  });

  final String after;
  final String before;

  Cursors copyWith({
    required String after,
    required String before,
  }) =>
      Cursors(
        after: after,
        before: before,
      );

  factory Cursors.fromRawJson(String str) => Cursors.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
        after: json["after"],
        before: json["before"],
      );

  Map<String, dynamic> toJson() => {
        "after": after,
        "before": before,
      };
}
