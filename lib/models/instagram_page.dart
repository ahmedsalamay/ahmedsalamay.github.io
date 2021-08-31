import 'dart:convert';

class InstagramPage {
  InstagramPage({
    required this.data,
    required this.paging,
  });

  final List<Media> data;
  final Paging paging;

  InstagramPage copyWith({
    required List<Media> data,
    required Paging paging,
  }) =>
      InstagramPage(
        data: data,
        paging: paging,
      );

  factory InstagramPage.fromRawJson(String str) =>
      InstagramPage.fromJson(json.decode(str));

  factory InstagramPage.fromJson(Map<String, dynamic> json) => InstagramPage(
        data: List<Media>.from(json["data"].map((x) => Media.fromJson(x))),
        paging: Paging.fromJson(json["paging"]),
      );
}

class Media {
  Media({
    required this.id,
    required this.mediaType,
    required this.mediaUrl,
    required this.username,
    required this.timestamp,
    this.caption,
  });

  final String id;
  final String mediaType;
  final String mediaUrl;
  final String username;
  final String timestamp;
  final String? caption;

  Media copyWith({
    required String id,
    required String mediaType,
    required String mediaUrl,
    required String username,
    required String timestamp,
    required String? caption,
  }) =>
      Media(
          id: id,
          caption: caption,
          mediaType: mediaType,
          mediaUrl: mediaUrl,
          timestamp: timestamp,
          username: username);

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        caption: json["caption"],
        mediaType: json["media_type"],
        mediaUrl: json["media_url"],
        username: json["username"],
        timestamp: json["timestamp"],
      );

  @override
  bool operator ==(other) => ((other) as Media).id == id;

  @override
  int get hashCode => int.parse(id);
}

class Paging {
  Paging({
    required this.cursors,
    required this.next,
  });

  final Cursors cursors;
  final String? next;

  Paging copyWith({
    required Cursors cursors,
    required String next,
  }) =>
      Paging(
        cursors: cursors,
        next: next,
      );

  factory Paging.fromRawJson(String str) => Paging.fromJson(json.decode(str));

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        cursors: Cursors.fromJson(json["cursors"]),
        next: json["next"],
      );
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

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
        after: json["after"],
        before: json["before"],
      );
}
