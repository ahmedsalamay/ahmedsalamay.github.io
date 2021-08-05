import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/facebook_album.dart';
import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/services/request_provider.dart';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final String facebookBaseUrl = 'https://graph.facebook.com/v11.0';

class FacebookRepository {
  FacebookRepository();

  //final _appLocalization = AppLocalizations.of(Get.context);
  Future<Result<AlbumPaging>> fetchAlbums({required String accessToken}) async {
    try {
      var response = await Dio().get(facebookBaseUrl +
          '/me/albums?fields=cover_photo{source},id,name,count&format=json&access_token=$accessToken');
      if (response.statusCode == 200) {
        var customerBalance = AlbumPaging.fromJson(json.decode(response.data));
        return Result.value(customerBalance);
      } else {
        return Result.error('error');
      }
    } on DioError {
      return Result.error(S.current.fimtoSoft);
    }
  }

  Future<Result<PhotoPaging>> fetchPhotos(
      {required String accessToken, required String albumId}) async {
    try {
      var response = await Dio().get(facebookBaseUrl +
          '/$albumId/photos?fields=id,name,width,height,photo,source&format=json&access_token=$accessToken');
      if (response.statusCode == 200) {
        if (kIsWeb) {
          var customerBalance = PhotoPaging.fromJson(response.data);
          return Result.value(customerBalance);
        } else {
          var customerBalance =
              PhotoPaging.fromJson(json.decode(response.data.toString()));
          return Result.value(customerBalance);
        }
      } else {
        return Result.error(response.data['ErrorString'].toString());
      }
    } on DioError {
      return Result.error(S.current.fimtoSoft);
    }
  }
}
