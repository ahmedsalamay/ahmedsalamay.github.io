import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CongratulationViewModel extends ChangeNotifier {
  CongratulationViewModel();

  Future<void> initAsync() async {}

  final ImagePicker _picker = ImagePicker();

  void continueAction() async {
    Get.toNamed(trackOrderRoute);
  }
}
