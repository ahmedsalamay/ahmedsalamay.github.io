import 'package:fimto_frame/models/instagram_page.dart';
import 'package:fimto_frame/repository/remote/instagram_repository.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

class InstagramPickerViewModel with ChangeNotifier {
  final InstagramRepository instagramRepository;
  String instagramAcessTokenCode;
  final MessageService messageService;

  InstagramPickerViewModel({
    required this.instagramRepository,
    required this.instagramAcessTokenCode,
    required this.messageService,
  });

  Future initAsync() async {
    if (kIsWeb) {
      final loc = Uri.parse(html.window.location.href);
      final code = loc.queryParameters["code"];
      instagramAcessTokenCode = code!;
    }

    var tokenResponse =
        await instagramRepository.getAccessToken(code: instagramAcessTokenCode);

    if (tokenResponse.isError) {
      messageService.showErrorSnackBar(
          title: S.current.sorry, message: 'Error');

      _isLoading = false;
      notifyListeners();
      return;
    }

    var token = tokenResponse.asValue!.value;

    var pageResponse = await instagramRepository.getInstagramImages(
        instaAccessToken: token.accessToken);

    if (pageResponse.isError) {
      messageService.showErrorSnackBar(
          title: S.current.sorry, message: 'Error');

      _isLoading = false;
      notifyListeners();
      return;
    }

    page = pageResponse.asValue!.value;
    _medias = page!.data;

    _isLoading = false;
    notifyListeners();
  }

  InstagramPage? page;

  List<Media> _medias = [];
  List<Media> get medias => _medias;

  final List<Media> _selectedMedias = [];
  List<Media> get selectedMedias => _selectedMedias;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  onMediaSelectedAction(Media media) {
    var isMediaAlreadySelected =
        _selectedMedias.any((element) => element == media);

    if (isMediaAlreadySelected) {
      _selectedMedias.remove(media);
    } else {
      _selectedMedias.add(media);
    }

    notifyListeners();
  }

  void onConfirmSelectionAction() {
    Get.back(result: _selectedMedias);
  }
}
