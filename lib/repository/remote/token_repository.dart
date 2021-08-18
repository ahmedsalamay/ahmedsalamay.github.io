import 'dart:io';
import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'package:fimto_frame/errors/auth_exception.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/token.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class TokenRepository {
  final Language? language;
//TODO change
  static const String _client_id = 'storekeeperclient';
  static const String _client_secret =
      '6jtxzxpy+ImAVeo+I6VrcK4dFxE4SgQ00pACvyp6oOQ=';
  static const String _scope =
      'openid profile email roles storeKeeperapi offline_access';

  static String get authUrl => 'https://fimtoframe.hadaf.website/connect/token';

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

    // client.options.contentType = 'application/json';
  }

  late Dio client;

  Future<Result<Token>> loginAsync(String phone, String password) async {
    client.options.contentType = 'application/x-www-form-urlencoded';
    try {
      var data = {
        'username': phone,
        'password': password,
        'grant_type': 'password',
        'client_id': kIsWeb ? 'mvc' : 'mobile',
        'client_secret': 'secret',
        'response_type': 'id_token token',
        'scope': 'fimto_api offline_access openid profile',
      };

      final response = await client.post(baseUrl + 'connect/token', data: data);
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

  Future<Result<Token>> registerAsync(
      String email, String phoneNumber, String password) async {
    try {
      var data = {
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password
      };

      final response = await client.post(baseUrl + 'Register', data: data);
      final token = Token.fromJson(response.data);

      return Result.value(token);
    } on DioError catch (error) {
      if (error.response!.statusCode == HttpStatus.badRequest) {
        var errorMsg = error.response!.data;
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
