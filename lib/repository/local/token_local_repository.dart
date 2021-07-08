import 'package:fimto_frame/models/token.dart';

class TokenLocalRepository {
  Future<void> saveToken(Token token) async {

    // prefs.setBool('isTokenSaved', true);
    // prefs.setString('accessToken', token.accessToken!);
    // prefs.setString('refreshToken', token.refreshToken ?? '');
    // prefs.setInt('expiresIn', token.expiresIn!);
  }

  Future<Token?> loadToken() async {

    // var isTokenSaved = prefs.getBool('isTokenSaved') ?? false;
    //
    // if (isTokenSaved) {
    //   return Token(
    //       accessToken: prefs.getString('accessToken'),
    //       expiresIn: prefs.getInt('expiresIn'),
    //       refreshToken: prefs.getString('refreshToken'));
    // }
    return null;
  }

  Future<void> clearToken() async {

  }
}
