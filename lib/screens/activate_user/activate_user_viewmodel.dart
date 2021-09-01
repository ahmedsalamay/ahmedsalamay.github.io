import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/repository/remote/token_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivateUserViewModel extends ChangeNotifier {
  final ConnectionService connectionService;
  final MessageService messageService;
  final TokenService tokenService;
  final TokenRepository tokenRepository;
  final String phoneNumber;

  ActivateUserViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.phoneNumber,
      required this.tokenRepository,
      required this.tokenService});

  Future<void> initAsync() async {}

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? _code;

  void onCodeChange(String password) {
    _code = password;
    notifyListeners();
  }

  void toggleLanguage() {}

  void activateAction() async {
    if (_code == null) {
      messageService.showErrorSnackBar(
          title: '', message: S.current.addAllField);
      return;
    }
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
    var response = await tokenRepository.activateUser(phoneNumber, _code!);
    setLoadingState(false);
    if (response.isError) {
      messageService.showErrorSnackBar(
          title: '', message: response.asError!.error.toString());
      return;
    }
    Get.offAllNamed(homeRoute);
  }

  void resendActivationCode() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: '', message: S.current.connectionErrorMsg);
      return;
    }
    // if (_isLoading) {
    //   messageService.showErrorSnackBar(
    //       title: '', message: S.current.loadingData);
    //   return;
    // }

    setLoadingState(true);
    var response = await tokenRepository.resendActivationCode(phoneNumber);
    setLoadingState(false);
    if (response.isError) {
      messageService.showErrorSnackBar(
          title: '', message: response.asError!.error.toString());
      return;
    }
    messageService.showSuccessSnackBar(title: '', message: 'sent successfully');
  }
}
