import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';

class ConnectionService extends ChangeNotifier {
  Future<bool> checkConnection() async {
    var state = await Connectivity().checkConnectivity();
    return state == ConnectivityResult.mobile ||
        state == ConnectivityResult.wifi;
  }
}
