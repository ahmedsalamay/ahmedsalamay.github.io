import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum paymentMethods { VodafoneCash, OrangeCash, EtisalatCash }

class ConfirmOrderViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  final Order order;

  ConfirmOrderViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.orderRepository,
      required this.order});

  DateTime? _deliveryDate;
  String? get deliveryDate => _deliveryDate?.toIso8601String();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void selectDeliveryDate(DateTime value) {
    _deliveryDate = value;
    notifyListeners();
  }

  void selectDeliveryTime(TimeOfDay time) {
    _deliveryDate =
        _deliveryDate!.add(Duration(hours: time.hour, minutes: time.minute));
    notifyListeners();
  }

  void onConfirmOrderAction() async {
    if (_deliveryDate == null) {
      messageService.showErrorInfoDialog('', S.current.pleaseChooseDate);
      return;
    }
    order.deliveryDate = _deliveryDate!;
    setLoadingState(true);
    var response = await orderRepository.submitOrder(order);
    setLoadingState(false);
    if (response.isError) {
      messageService.showErrorInfoDialog(
          '', response.asError!.error.toString());

      return;
    }
    Get.toNamed(congratulationRoute);
  }

  Future<void> onConfirmOrderActionWeb() async {
    if (_deliveryDate == null) {
      messageService.showErrorInfoDialog('', S.current.pleaseChooseDate);
      return;
    }
    order.deliveryDate = _deliveryDate!;
    setLoadingState(true);
    var response = await orderRepository.submitOrder(order);
    setLoadingState(false);
    if (response.isError) {
      messageService.showErrorInfoDialog(
          '', response.asError!.error.toString());

      return Future.error('');
    }
  }
}
