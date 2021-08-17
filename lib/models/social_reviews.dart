import 'dart:convert';

List<SocialReviews> socialReviewsFromJson(String str) =>
    List<SocialReviews>.from(
        json.decode(str).map((x) => SocialReviews.fromJson(x)));

String socialReviewsToJson(List<SocialReviews> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SocialReviews {
  SocialReviews({
    required this.reviewLink,
    required this.reviewerName,
    required this.socialMediaType,
    required this.reviewText,
  });

  final String reviewLink;
  final String reviewerName;
  final String socialMediaType;
  final String reviewText;

  factory SocialReviews.fromJson(Map<String, dynamic> json) => SocialReviews(
        reviewLink: json["reviewLink"] == null ? null : json["reviewLink"],
        reviewerName:
            json["reviewerName"] == null ? null : json["reviewerName"],
        socialMediaType:
            json["socialMediaType"] == null ? null : json["socialMediaType"],
        reviewText: json["reviewText"] == null ? null : json["reviewText"],
      );

  Map<String, dynamic> toJson() => {
        "reviewLink": reviewLink == null ? null : reviewLink,
        "reviewerName": reviewerName == null ? null : reviewerName,
        "socialMediaType": socialMediaType == null ? null : socialMediaType,
        "reviewText": reviewText == null ? null : reviewText,
      };
}
