import 'package:fimto_frame/models/home_page_configuration.dart';
import 'package:fimto_frame/models/social_reviews.dart';
import 'package:fimto_frame/repository/remote/configuration_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final ConnectionService connectionService;
  final MessageService messageService;
  final ConfigurationRepository configurationRepository;

  HomeViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.configurationRepository});

  HomePageConfiguration? _homePageConfiguration;

  HomePageConfiguration? get homePageConfiguration => _homePageConfiguration;

  List<SocialReviews> _socialReviews = [];

  List<SocialReviews> get socialReviews => _socialReviews;

  bool _isLoadingConfigurations = true;

  bool get isLoadingConfigurations => _isLoadingConfigurations;

  void setLoadingConfigurations(bool value) {
    _isLoadingConfigurations = value;
    notifyListeners();
  }

  bool _isLoadingReviews = true;

  bool get isLoadingReviews => _isLoadingReviews;

  void setLoadingReviews(bool value) {
    _isLoadingReviews = value;
    notifyListeners();
  }

  Future<HomePageConfiguration> loadHomePageConfiguration() async {
    var result = await configurationRepository.getHomePageData();
    if (result.isError) {
      return Future.error(result.asError!.error);
    }
    return result.asValue!.value;
  }

  Future<List<SocialReviews>> loadHomeSocialReviews() async {
    var result = await configurationRepository.getSocialReviews();
    if (result.isError) {
      return Future.error(result.asError!.error);
    }
    return result.asValue!.value;
  }
}
