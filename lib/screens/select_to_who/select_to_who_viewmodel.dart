import 'package:flutter/material.dart';

class SelectToWhoViewModel extends ChangeNotifier {
  SelectToWhoViewModel();

  Future<void> initAsync() async {}

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
}
