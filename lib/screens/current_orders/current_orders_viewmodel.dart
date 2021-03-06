import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/order_status.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentOrdersViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  final Order order;
  CurrentOrdersViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.orderRepository,
      required this.order}) {
    initAsync();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final List<OrderStatus> _currentOrders = [];
  List<OrderStatus> get currentOrders => _currentOrders;

  Future<void> initAsync() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: S.current.connectionErrorHeader,
          message: S.current.connectionErrorMsg);
      return;
    }
    var ordersResponse = await orderRepository.getOrdersStatus();
    if (ordersResponse.isError) {
      messageService.showErrorSnackBar(title: '', message: 'Error Happened');
      setLoadingState(false);
      return;
    }
    _currentOrders.addAll(ordersResponse.asValue!.value);
    setLoadingState(false);
  }

  void navigateToStatusScreen(OrderStatus order) {
    Get.toNamed(trackOrderRoute, arguments: order);
  }

  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
