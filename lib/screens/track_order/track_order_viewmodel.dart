import 'package:fimto_frame/models/order_status.dart';
import 'package:flutter/material.dart';

class TrackOrderViewModel extends ChangeNotifier {
  final OrderStatus order;
  TrackOrderViewModel({required this.order});

  Future<void> initAsync() async {}
}
