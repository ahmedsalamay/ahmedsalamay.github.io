import 'dart:io';
import 'dart:typed_data';

import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SelectToWhoViewModel extends ChangeNotifier {
  SelectToWhoViewModel();

  Future<void> initAsync() async {}

  bool _giftSelected = false;
  bool get giftSelected => _giftSelected;

  bool _forMeSelected = false;
  bool get forMeSelected => _forMeSelected;

  bool get isAnySelected => _giftSelected || _forMeSelected;

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
      if (kIsWeb) {
        // FilePickerResult? result = await FilePicker.platform.pickFiles(
        //     allowMultiple: true,
        //     type: FileType.image,
        //     onFileLoading: (status) {
        //       print('FilePickerStatus: $status');
        //       if (status == FilePickerStatus.done) {
        //         print('FilePickerStatus: $status');
        //
        //       }
        //     });
        // if (result != null) {
        //   List<Uint8List> files = result.files.map((e) => e.bytes!).toList();
        //   // List<File> files = result.files.map((e) => File(e.path!)).toList();
        //   Get.toNamed(chooseFrameRoute, arguments: files);
        // }
        Get.toNamed(chooseFrameRoute);
      } else {
        // final List<PickedFile>? pickedFiles = await _picker.getMultiImage();
        // if (pickedFiles != null)
        //   Get.toNamed(chooseFrameRoute, arguments: pickedFiles);
        // FilePickerResult? result = await FilePicker.platform.pickFiles(
        //   allowMultiple: true,
        //   type: FileType.image,
        // );
        // if (result != null) {
        //   List<File> files = result.paths.map((path) => File(path!)).toList();
        //   // List<File> files = result.files.map((e) => File(e.path!)).toList();
        //   Get.toNamed(chooseFrameRoute, arguments: files);
        // }
        Get.toNamed(chooseFrameRoute);
      }
    } else {
      Get.toNamed(leaveMessageRoute);
    }
  }
}
