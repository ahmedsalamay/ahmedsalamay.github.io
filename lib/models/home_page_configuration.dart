import 'dart:convert';

HomePageConfiguration homePageConfigurationFromJson(String str) =>
    HomePageConfiguration.fromJson(json.decode(str));

class HomePageConfiguration {
  HomePageConfiguration({
    required this.videoLink,
    required this.imageLink,
    required this.textOffer,
    required this.packagePrice,
    required this.packageSize,
    required this.extraImagePrice,
    required this.deliveryFee,
  });

  final String videoLink;
  final String imageLink;
  final String textOffer;
  final double packagePrice;
  final double packageSize;
  final double extraImagePrice;
  final double deliveryFee;

  factory HomePageConfiguration.fromJson(Map<String, dynamic> json) =>
      HomePageConfiguration(
        videoLink: json['config']["videoLink"].split('v=')[1].split('&')[0],
        imageLink: json['config']["imageLink"],
        textOffer: json['config']["textOffer"],
        deliveryFee: json['prices']["deliveryFees"].toDouble(),
        packagePrice: json['prices']["packagePrice"].toDouble(),
        packageSize: json['prices']["packageImageNumber"].toDouble(),
        extraImagePrice: json['prices']["extraImagePrice"].toDouble(),
      );
}
