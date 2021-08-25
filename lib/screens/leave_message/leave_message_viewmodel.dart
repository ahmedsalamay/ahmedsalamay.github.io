import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveMessageViewModel extends ChangeNotifier {
  final MessageService messageService;
  final Order order;
  LeaveMessageViewModel({required this.messageService, required this.order});

  String? _message;
  String? get message => _message;

  void onMessageEntered(String value) {
    _message = value;
  }

  void continueAction() async {
    if (_message == null) {
      return;
    }
    order.giftText = _message;
    Get.toNamed(chooseFrameRoute);
  }
}
