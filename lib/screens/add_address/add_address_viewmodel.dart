import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/repository/local/token_local_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';

class AddAddressViewModel extends ChangeNotifier {
  final TokenLocalRepository tokenLocalRepository;
  final Language language;

  AddAddressViewModel(
      {required this.tokenLocalRepository, required this.language});

  Future<void> initAsync() async {
    navigationAction();
  }

  void navigationAction() {
    Get.offNamed(homeRoute);
    // if (!_isUrlsSaved) {
    //   Get.offNamed(codeRoute);
    // } else if (!_isUserSaved) {
    //   Get.offNamed(loginRoute);
    // } else {
    //   Get.offNamed(
    //     homeRoute,
    //   );
    // }
  }
}
