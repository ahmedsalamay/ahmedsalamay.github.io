import 'package:fimto_frame/repository/remote/instagram_repository.dart';
import 'package:flutter/foundation.dart';
//import 'dart:html' as html;

class InstagramPickerViewModel with ChangeNotifier {
  final InstagramRepository instagramRepository;
  String instagramAcessTokenCode;

  InstagramPickerViewModel({
    required this.instagramRepository,
    required this.instagramAcessTokenCode,
  });

  Future initAsync() async {
    if (kIsWeb) {
   /*   final loc = Uri.parse(html.window.location.href);
      final code = loc.queryParameters["code"];
      instagramAcessTokenCode = code!;*/
    }

    var token =
        await instagramRepository.getAccessToken(code: instagramAcessTokenCode);
    var page = await instagramRepository.getInstagramImages(
        instaAccessToken: token.asValue!.value.accessToken);
    var images = page.asValue!.value.data;
  }
}
