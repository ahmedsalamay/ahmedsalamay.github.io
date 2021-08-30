import 'dart:io';

import 'package:fimto_frame/models/instagram_page.dart';
import 'package:fimto_frame/models/instagram_token.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:fimto_frame/generated/l10n.dart';

class InstagramRepository {
  Future<Result<InstgramToken>> getAccessToken({required String code}) async {
    try {
      var data = {
        'grant_type': 'authorization_code',
        'client_id': '400912798059223',
        'client_secret': '327b32bfc8045243dc58863df2f4f37a',
        'code': code,
        'redirect_uri': 'https://hadaf.vemtto.pickinstagram.com/',
      };

      var response = await Dio().post(
        'https://api.instagram.com/oauth/access_token',
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
          'https://graph.instagram.com/me/media?fields=id,caption,media_url&access_token=IGQVJVWUNOaWpaVVVWd3NIVUcybUQ5UUEzVU56MDZA4THFkbFhYc3h3dDVhSTBxVGV6OGNUd3B4V3o2R0dnWTNxR0ZAkUms3OC1PVFd1ZAjhqQzNUZAnZASeVI1ZAGlCX294UUZAMYTZA5TmVhczlhd3hTdEU1bnA3b19PTGpOemZAJ');

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
