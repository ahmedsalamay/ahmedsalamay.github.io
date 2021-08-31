enum frames { clean, classic, permise, shaded }
enum orderType { gift, forMe }
enum OrderStatesEn {
  Pending,
  Accecpted,
  onPrepared,
  onDelivery,
  Delivered,
  Refused
}
enum OrderStatesAr {
  Pending,
  Accecpted,
  onPrepared,
  onDelivery,
  Delivered,
  Refused
}

const String facebookBaseUrl = 'https://graph.facebook.com/v11.0';
const String baseUrl = 'https://fimtoframe.hadaf.website/';
// final String baseUrl = 'http://192.168.1.209/';

const int minNumber = 11;

class InstagramConst {
  static const String clientId = '400912798059223';
  static const String appSecret = '327b32bfc8045243dc58863df2f4f37a';
  static const String redirectUri = 'https://hadaf.vemtto.pickinstagram.com/';
  static const String scope = 'user_profile,user_media';
  static const String responseType = 'code';
  static const String grantTypeCode = 'authorization_code';
  static const String mediaFields =
      'id,media_type,media_url,username,timestamp,caption';
  static const String authorizeCodeApiUrl =
      'https://api.instagram.com/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&response_type=$responseType';
  static const String oauthTokenApiUrl =
      'https://api.instagram.com/oauth/access_token';
  static const String mediaApiUrl = 'https://graph.instagram.com/me/media';
}
