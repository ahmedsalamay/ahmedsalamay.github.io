import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveMessageViewModel extends ChangeNotifier {
  LeaveMessageViewModel();

  Future<void> initAsync() async {}

  void continueAction() async {
    Get.toNamed(chooseFrameRoute);
  }
}
