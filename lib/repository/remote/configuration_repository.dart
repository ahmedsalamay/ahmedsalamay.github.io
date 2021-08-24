import 'package:fimto_frame/models/home_page_configuration.dart';
import 'package:fimto_frame/models/social_reviews.dart';
import 'package:fimto_frame/services/request_provider.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';

class ConfigurationRepository {
  final RequestProvider requestProvider;
  ConfigurationRepository(this.requestProvider);

  Future<Result<HomePageConfiguration>> getHomePageData() async {
    try {
      var response = await requestProvider.getAsync('api/HomePage');
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
      var response = await requestProvider.getAsync('api/Review');
      if (response.statusCode == 200) {
        var socialReviews = List<SocialReviews>.from(
            response.data.map((e) => SocialReviews.fromJson(e)));
        return Result.value(socialReviews);
      } else {
        return Result.error(response.data['ErrorString'].toString());
      }
    } on DioError {
      return Result.error(DioError);
    }
  }
}
