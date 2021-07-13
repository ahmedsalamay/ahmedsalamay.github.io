import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TrackOrderViewModel extends ChangeNotifier {
  TrackOrderViewModel();

  Future<void> initAsync() async {}

  final ImagePicker _picker = ImagePicker();

  void continueAction() async {
    final List<PickedFile>? pickedFiles = await _picker.getMultiImage();
    if (pickedFiles != null)
      Get.toNamed(chooseFrameRoute, arguments: pickedFiles);
  }
}
