import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fimto_frame/models/constants.dart';

class SelectToWhoViewModel extends ChangeNotifier {
  final Order order;
  SelectToWhoViewModel({required this.order});

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
      order.typeofOrder = orderType.forMe.toString().split('.')[1];
      Get.toNamed(chooseFrameRoute);
    } else {
      order.typeofOrder = orderType.gift.toString().split('.')[1];
      Get.toNamed(leaveMessageRoute);
    }
  }
}
