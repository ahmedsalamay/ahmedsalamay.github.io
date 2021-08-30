import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/repository/remote/preference.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends ChangeNotifier {
  final ConnectionService connectionService;
  final MessageService messageService;
  final TokenService tokenService;

  LoginViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.tokenService});

  Future<void> initAsync() async {}

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? _phoneNumber;
  String? _password;

  void onPhoneNumberChange(String userName) {
    _phoneNumber = userName;
    notifyListeners();
  }

  void onPasswordChange(String password) {
    _password = password;
    notifyListeners();
  }

  String? validatePhoneNumber(String? phone) =>
      !_isValidPhoneNumber(phone) ? S.current.phoneNumberError : null;

  String? validatePassword(String? password) =>
      password!.isEmpty ? S.current.passwordError : null;

  void toggleLanguage() {}

  void logInAction(GlobalKey<FormState> formKey) {
    final form = formKey.currentState!;
    if (form.validate()) {
      _logIn();
    }
  }

  void continueAsGuestAction() {
    Get.toNamed(homeRoute);
  }

  void _logIn() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: '', message: S.current.connectionErrorMsg);
      return;
    }

    if (_isLoading) {
      messageService.showErrorSnackBar(
          title: '', message: S.current.loadingData);
      return;
    }

    setLoadingState(true);

    var response = await tokenService.loginAsync(_phoneNumber!, _password!);
    if (response.isError) {
      messageService.showErrorSnackBar(
          title: '', message: response.asError!.error.toString());
      setLoadingState(false);
      return;
    }
    setLoadingState(false);
    final preferences = await Preferences.getInstance();
    preferences.setIsLogged(true);
    Get.offAllNamed(homeRoute);
  }

  bool _isValidPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return value.length == minNumber;
  }
}
