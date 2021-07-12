import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SelectToWhoViewModel extends ChangeNotifier {
  SelectToWhoViewModel();

  Future<void> initAsync() async {}

  final ImagePicker _picker = ImagePicker();

  bool _giftSelected = false;
  bool get giftSelected => _giftSelected;

  bool _forMeSelected = false;
  bool get forMeSelected => _forMeSelected;

  void onGiftSelected() {
    _forMeSelected = false;
    _giftSelected = true;
    notifyListeners();
  }

  void onForMeSelected() {
    _giftSelected = false;
    _forMeSelected = true;
    notifyListeners();
  }

  void continueAction() async {
    if (_forMeSelected) {
      final List<PickedFile>? pickedFiles = await _picker.getMultiImage();
      if (pickedFiles != null)
        Get.toNamed(chooseFrameRoute, arguments: pickedFiles);
    } else {
      Get.toNamed(leaveMessageRoute);
    }
  }
}
