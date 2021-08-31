import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/instagram_page.dart';
import 'package:fimto_frame/models/instagram_token.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:fimto_frame/generated/l10n.dart';

class InstagramRepository {
  Future<Result<InstgramToken>> getAccessToken({required String code}) async {
    try {
      var data = {
        'grant_type': InstagramConst.grantTypeCode,
        'client_id': InstagramConst.clientID,
        'client_secret': InstagramConst.appSecret,
        'code': code,
        'redirect_uri': InstagramConst.redirectUri,
      };

      var response = await Dio().post(
        InstagramConst.oauthTokenApiUrl,
        data: data,
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );

      if (response.statusCode == 200) {
        var token = InstgramToken.fromJson(response.data);
        return Result.value(token);
      } else {
        return Result.error('error');
      }
    } on DioError {
      return Result.error(S.current.fimtoSoft);
    }
  }

  Future<Result<InstagramPage>> getInstagramImages(
      {required instaAccessToken}) async {
    try {
      var response = await Dio().get(
          '${InstagramConst.mediaApiUrl}?fields=${InstagramConst.mediaFields}&access_token=$instaAccessToken');

      if (response.statusCode == 200) {
        var page = InstagramPage.fromJson(response.data);
        return Result.value(page);
      } else {
        return Result.error('error');
      }
    } on DioError {
      return Result.error(S.current.fimtoSoft);
    }
  }
}
