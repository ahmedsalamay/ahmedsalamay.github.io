import 'dart:convert';

HomePageConfiguration homePageConfigurationFromJson(String str) =>
    HomePageConfiguration.fromJson(json.decode(str));

String homePageConfigurationToJson(HomePageConfiguration data) =>
    json.encode(data.toJson());

class HomePageConfiguration {
  HomePageConfiguration({
    required this.videoLink,
    required this.imageLink,
    required this.textOffer,
  });

  final String videoLink;
  final String imageLink;
  final String textOffer;

  factory HomePageConfiguration.fromJson(Map<String, dynamic> json) =>
      HomePageConfiguration(
        videoLink: json["videoLink"],
        imageLink: json["imageLink"],
        textOffer: json["textOffer"],
      );

  Map<String, dynamic> toJson() => {
        "videoLink": videoLink,
        "imageLink": imageLink,
        "textOffer": textOffer,
      };
}
