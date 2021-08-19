import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum paymentMethods { VodafoneCash, OrangeCash, EtisalatCash }

class AddPaymentMethodViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  final Order order;
  AddPaymentMethodViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.orderRepository,
      required this.order});

  bool _isPromoCodeLoading = false;
  bool get isPromoCodeLoading => _isPromoCodeLoading;

  bool _isPromoCodeActivated = false;
  bool get isPromoCodeActivated => _isPromoCodeActivated;

  String? promoCode;

  void setPromoCodeLoadingState(bool value){
    _isPromoCodeLoading = false;
    notifyListeners();
  }
  void setPromoCodeActivatedState(bool value){
    _isPromoCodeActivated = false;
    notifyListeners();
  }

  void applyPromoCode()async{}

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

  void onConfirmPaymentMethodAction() {
    order.paymentMethod = _selectedPaymentMethods!.companyName;
    Get.toNamed(confirmOrderRoute);
  }
}
