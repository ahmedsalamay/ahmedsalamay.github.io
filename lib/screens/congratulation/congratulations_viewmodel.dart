import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationViewModel extends ChangeNotifier {
  CongratulationViewModel();

  Future<void> initAsync() async {}


  void continueAction() async {
    Get.toNamed(trackOrderRoute);
  }
}
