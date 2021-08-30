import 'dart:convert';

class InstgramToken {
  InstgramToken({
    required this.accessToken,
    required this.userId,
  });

  final String accessToken;
  final double userId;

  InstgramToken copyWith({
    required String accessToken,
    required double userId,
  }) =>
      InstgramToken(
        accessToken: accessToken,
        userId: userId,
      );

  factory InstgramToken.fromRawJson(String str) =>
      InstgramToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InstgramToken.fromJson(Map<String, dynamic> json) => InstgramToken(
        accessToken: json["access_token"],
        userId: json["user_id"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user_id": userId,
      };
}
