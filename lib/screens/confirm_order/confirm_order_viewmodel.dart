import 'package:flutter/material.dart';

enum paymentMethods { VodafoneCash, OrangeCash, EtisalatCash }

class ConfirmOrderViewModel extends ChangeNotifier {
  ConfirmOrderViewModel();

  Future<void> initAsync() async {}

  bool isVodafoneSelected() =>
      selectedPaymentMethod != null &&
      selectedPaymentMethod == paymentMethods.VodafoneCash;
  bool isOrangeSelected() =>
      selectedPaymentMethod != null &&
      selectedPaymentMethod == paymentMethods.OrangeCash;
  bool isEtisalatSelected() =>
      selectedPaymentMethod != null &&
      selectedPaymentMethod == paymentMethods.EtisalatCash;

  paymentMethods? selectedPaymentMethod;

  void selectPaymentMethodAction(paymentMethods payment) {
    switch (payment) {
      case paymentMethods.VodafoneCash:
        selectedPaymentMethod = paymentMethods.VodafoneCash;
        break;
      case paymentMethods.OrangeCash:
        selectedPaymentMethod = paymentMethods.OrangeCash;
        break;
      case paymentMethods.EtisalatCash:
        selectedPaymentMethod = paymentMethods.EtisalatCash;
    }
    notifyListeners();
  }
}
