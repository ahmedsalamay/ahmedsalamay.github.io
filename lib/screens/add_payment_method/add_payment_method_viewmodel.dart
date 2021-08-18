import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';

enum paymentMethods { VodafoneCash, OrangeCash, EtisalatCash }

class AddPaymentMethodViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  AddPaymentMethodViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.orderRepository});

  Future<List<PaymentsMethods>> loadPaymentMethods() async {
    var response = await orderRepository.getPaymentMethods();
    if (response.isError) {
      return Future.error(response.asError!.error);
    }
    return response.asValue!.value;
  }

  PaymentsMethods? _selectedPaymentMethods;
  PaymentsMethods? get selectedPaymentMethods => _selectedPaymentMethods;
  void onPaymentMethodSelection(PaymentsMethods value) {
    _selectedPaymentMethods = value;
    notifyListeners();
  }



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
