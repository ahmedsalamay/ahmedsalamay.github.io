import 'package:fimto_frame/repository/remote/instagram_repository.dart';
import 'package:flutter/foundation.dart';

class InstagramPickerViewModel with ChangeNotifier {
  final InstagramRepository instagramRepository;
  final String instagramAcessTokenCode;

  InstagramPickerViewModel({
    required this.instagramRepository,
    required this.instagramAcessTokenCode,
  });

  Future initAsync() async {
    var token =
        await instagramRepository.getAccessToken(code: instagramAcessTokenCode);
    var page = await instagramRepository.getInstagramImages(
        instaAccessToken: token.asValue!.value.accessToken);
    var images = page.asValue!.value.data;
  }
}
