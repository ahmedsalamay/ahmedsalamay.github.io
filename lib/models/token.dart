class Token {
  String? accessToken;
  int? expiresIn;
  String? refreshToken;

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
