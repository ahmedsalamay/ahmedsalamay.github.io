import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/repository/local/token_local_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';

class SplashViewModel extends ChangeNotifier {
  final TokenLocalRepository tokenLocalRepository;
  final Language language;

  SplashViewModel({required this.tokenLocalRepository, required this.language});

  Future<void> initAsync() async {
    navigationAction();
  }

  void navigationAction() {
    Get.offNamed(addAddressRoute);
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
