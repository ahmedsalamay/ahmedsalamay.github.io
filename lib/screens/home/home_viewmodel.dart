import 'package:fimto_frame/models/home_page_configuration.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/social_reviews.dart';
import 'package:fimto_frame/repository/remote/configuration_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final ConnectionService connectionService;
  final MessageService messageService;
  final ConfigurationRepository configurationRepository;
  final Order order;

  HomeViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.order,
      required this.configurationRepository}) {
    _homePageConfiguration = loadHomePageConfiguration();
  }

  late Future<HomePageConfiguration> _homePageConfiguration;
  Future<HomePageConfiguration> get homePageConfiguration =>
      _homePageConfiguration;

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
    var config = result.asValue!.value;
    order
      ..deliveryFee = config.deliveryFee
      ..extraImagePrice = config.extraImagePrice
      ..packageSize = config.packageSize
      ..packagePrice = config.packagePrice;
    return config;
  }

  Future<List<SocialReviews>> loadHomeSocialReviews() async {
    var result = await configurationRepository.getSocialReviews();
    if (result.isError) {
      return Future.error(result.asError!.error);
    }
    return result.asValue!.value;
  }
}
