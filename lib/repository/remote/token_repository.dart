import 'dart:io';
import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'package:fimto_frame/errors/auth_exception.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/token.dart';

class TokenRepository {
  final Language? language;
//TODO change
  static const String _clientId = 'storekeeperclient';
  static const String _clientSecret =
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
        'client_id': 'mobile',
        'client_secret': 'secret',
        'response_type': 'id_token token',
        'scope': 'IdentityServerApi',
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

  Future<Result<bool>> registerAsync(
      String email, String phoneNumber, String password) async {
    try {
      var data = {
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password
      };

      final response = await client.post(baseUrl + 'Register', data: data);
      if (response.statusCode == 200) {
        return Result.value(true);
      }
      return Result.error(S.current.somethingWentWrong);
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
              'grant_type=refresh_token&client_id=$_clientId&client_secret=$_clientSecret&refresh_token=$refreshToken');
      final newToken = Token.fromJson(response.data);
      return Result.value(newToken);
    } on DioError {
      throw AuthException(token);
    }
  }

  Future<Result<bool>> resendActivationCode(String phoneNumber) async {
    try {
      final response = await client
          .post(baseUrl + 'ResendActivationCode?phone=$phoneNumber');
      if (response.statusCode == 200) {
        return Result.value(true);
      }
      return Result.error(S.current.somethingWentWrong);
    } on DioError catch (error) {
      if (error.response!.statusCode == HttpStatus.badRequest) {
        var errorMsg = error.response!.data;
        return Result.error(errorMsg);
      }
      return Result.error('');
    }
  }

  Future<Result<bool>> activateUser(String phoneNumber, String code) async {
    try {
      final response = await client
          .post(baseUrl + 'ActivateUser?phone=$phoneNumber&Code=$code');
      if (response.statusCode == 200) {
        return Result.value(true);
      }
      return Result.error(S.current.somethingWentWrong);
    } on DioError catch (error) {
      if (error.response!.statusCode == HttpStatus.badRequest) {
        var errorMsg = error.response!.data;
        return Result.error(errorMsg);
      }
      return Result.error('');
    }
  }
}
