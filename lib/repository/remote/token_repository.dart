import 'dart:io';

import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'package:fimto_frame/errors/auth_exception.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/token.dart';

class TokenRepository {
  final Language? language;
//TODO change
  static const String _client_id = 'storekeeperclient';
  static const String _client_secret =
      '6jtxzxpy+ImAVeo+I6VrcK4dFxE4SgQ00pACvyp6oOQ=';
  static const String _scope =
      'openid profile email roles storeKeeperapi offline_access';

  TokenRepository({
    required this.language,
  }) {
    client = Dio();
    client.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));

    client.options.headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    client.options.contentType = 'application/x-www-form-urlencoded';
  }

  late Dio client;

  Future<Result<Token>> loginAsync(String? username, String? password) async {
    try {
      var data = {
        'username': username,
        'password': password,
        'grant_type': 'password',
        'client_id': _client_id,
        'client_secret': _client_secret,
        'scope': _scope,

        ///why it is like that? is `en` or `ar` is enough? => no it is a back end contract
        ///and it will not return the data localized, so u SHOULD pass `EG` or `US`.
        'Accept-Language':
            language!.languageCode == Language.arabicCode ? 'ar-EG' : 'en-US',
      };

      final response =
          await client.post('companyUrls!.tokenEndPoint!', data: data);
      final token = Token.fromJson(response.data);

      return Result.value(token);
    } on DioError catch (error) {
      if (error.response!.statusCode == HttpStatus.badRequest) {
        var errorMsg = error.response!.data['error_description'];

        return Result.error(errorMsg);
      }
      return Result.error('');
    }
  }

  Future<Result<Token>> refreshToken(Token token) async {
    try {
      var refreshToken = token.refreshToken;
      final response = await client.post('companyUrls!.tokenEndPoint!',
          data:
              'grant_type=refresh_token&client_id=$_client_id&client_secret=$_client_secret&refresh_token=$refreshToken');
      final newToken = Token.fromJson(response.data);
      return Result.value(newToken);
    } on DioError {
      throw AuthException(token);
    }
  }
}
