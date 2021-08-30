import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterViewModel extends ChangeNotifier {
  final ConnectionService connectionService;
  final MessageService messageService;
  final TokenService tokenService;

  RegisterViewModel(
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
  String? _email;

  void onPhoneNumberChange(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void onEmailChange(String email) {
    _email = email;
    notifyListeners();
  }

  void onPasswordChange(String password) {
    _password = password;
    notifyListeners();
  }

  String? validatePhoneNumber(String? phone) =>
      !_isValidPhoneNumber(phone) ? S.current.phoneNumberError : null;

  String? validateEmailAddress(String? email) =>
      !_isEmailValid(email) ? S.current.phoneNumberError : null;

  String? validatePassword(String? password) =>
      password!.isEmpty ? S.current.passwordError : null;

  void toggleLanguage() {}

  void registerAction(GlobalKey<FormState> formKey) {
    final form = formKey.currentState!;
    if (form.validate()) {
      _register();
    }
  }

  void _register() async {
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

    var response =
        await tokenService.registerAsync(_phoneNumber!, _email!, _password!);
    if (response.isError) {
      messageService.showErrorSnackBar(
          title: '', message: response.asError!.error.toString());
      setLoadingState(false);
      return;
    }

    setLoadingState(false);
    Get.offAllNamed(homeRoute);
  }

  bool _isEmailValid(String? email) {
    if (email == null) return false;
    // return RegExp(
    //         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
    //     .hasMatch(email);
    return true;
  }

  bool _isValidPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return value.length == minNumber;
  }
}
