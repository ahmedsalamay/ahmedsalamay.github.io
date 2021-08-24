import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentMethodViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  final Order order;
  AddPaymentMethodViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.orderRepository,
      required this.order}) {
    paymentFuture = loadPaymentMethods();
  }

  List<PaymentsMethods> _paymentMethods = [];
  List<PaymentsMethods> get paymentMethods => _paymentMethods;

  late Future<List<PaymentsMethods>> paymentFuture;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isPromoCodeLoading = false;
  bool get isPromoCodeLoading => _isPromoCodeLoading;

  bool _isPromoCodeActivated = false;
  bool get isPromoCodeActivated => _isPromoCodeActivated;

  String? _promoCode;
  set promoCode(String value) {
    _promoCode = value;
  }

  void setPromoCodeLoadingState(bool value) {
    _isPromoCodeLoading = value;
    notifyListeners();
  }

  void setPromoCodeActivatedState(bool value) {
    _isPromoCodeActivated = value;
    notifyListeners();
  }

  void applyPromoCode() async {
    if (_promoCode == null) return;
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: S.current.connectionErrorHeader,
          message: S.current.connectionErrorMsg);
      return;
    }
    setPromoCodeLoadingState(true);
    var response = await orderRepository.checkPromoCode(_promoCode!);
    if (response.isError) {
      setPromoCodeLoadingState(false);
      messageService.showErrorSnackBar(title: '', message: 'Not found');
      return;
    }
    setPromoCodeLoadingState(false);
    setPromoCodeActivatedState(true);
    order.applyPromoCode(response.asValue!.value);
    order.calculateTotal();
  }

  Future<List<PaymentsMethods>> loadPaymentMethods() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: S.current.connectionErrorHeader,
          message: S.current.connectionErrorMsg);
      return Future.error('');
    }
    isLoading = true;
    var response = await orderRepository.getPaymentMethods();
    if (response.isError) {
      isLoading = false;
      return Future.error(response.asError!.error);
    }
    _paymentMethods.addAll(response.asValue!.value);
    isLoading = false;
    notifyListeners();
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
