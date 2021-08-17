import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/facebook_album.dart';
import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/models/home_page_configuration.dart';
import 'package:fimto_frame/models/social_reviews.dart';
import 'package:fimto_frame/services/request_provider.dart';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ConfigurationRepository {
  final RequestProvider requestProvider;
  ConfigurationRepository(this.requestProvider);

  Future<Result<HomePageConfiguration>> getHomePageData() async {
    try {
      var response = await requestProvider.getAsync(baseUrl + 'api/HomePage');
      if (response.statusCode == 200) {
        var homePageConfiguration =
            HomePageConfiguration.fromJson(response.data);
        return Result.value(homePageConfiguration);
      } else {
        return Result.error('error');
      }
    } on DioError {
      return Result.error(DioError);
    }
  }

  Future<Result<List<SocialReviews>>> getSocialReviews() async {
    try {
      var response = await requestProvider.getAsync(baseUrl + 'Review');
      if (response.statusCode == 200) {
        var socialReviews =
            json.decode(response.data).map((x) => SocialReviews.fromJson(x));
        return Result.value(socialReviews);
      } else {
        return Result.error(response.data['ErrorString'].toString());
      }
    } on DioError {
      return Result.error(DioError);
    }
  }
}
