import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: 1)
class Token {
  @HiveField(0)
  String accessToken;
  @HiveField(1)
  int expiresIn;
  @HiveField(2)
  String refreshToken;

  Token({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json['access_token'],
        expiresIn: json['expires_in'],
        refreshToken: json['refresh_token'],
      );
}
