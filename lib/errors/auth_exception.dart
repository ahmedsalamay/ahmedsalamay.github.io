import 'package:fimto_frame/models/token.dart';

class AuthException implements Exception {
  AuthException(this.token);

  Token token;

  @override
  String toString() {
    return 'This token is not valid AccessToken= ${token.accessToken} ... RefreshToken= ${token.refreshToken}';
  }
}
