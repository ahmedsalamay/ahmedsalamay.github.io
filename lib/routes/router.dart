import 'dart:io';
import 'dart:typed_data';

import 'package:fimto_frame/screens/add_address/add_address_view.dart';
import 'package:fimto_frame/screens/add_payment_method/add_payment_method_view.dart';
import 'package:fimto_frame/screens/choose_frame/choose_frame_view.dart';
import 'package:fimto_frame/screens/confirm_order/confirm_order_view.dart';
import 'package:fimto_frame/screens/congratulation/congratulation_view.dart';
import 'package:fimto_frame/screens/home/home_view.dart';
import 'package:fimto_frame/screens/leave_message/leave_message_view.dart';
import 'package:fimto_frame/screens/login/login_view.dart';
import 'package:fimto_frame/screens/onbording/onbording.dart';
import 'package:fimto_frame/screens/register/register_view.dart';
import 'package:fimto_frame/screens/select_to_who/select_to_who_view.dart';
import 'package:fimto_frame/screens/splash/splash_view.dart';
import 'package:fimto_frame/screens/track_order/track_order_view.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'router_names.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(
          builder: (context) => SplashScreen(), settings: settings);
    case onBoardRoute:
      return MaterialPageRoute(
          builder: (context) => OnBoardView(), settings: settings);
    case homeRoute:
      return MaterialPageRoute(
          builder: (context) => HomeView(), settings: settings);
    case addAddressRoute:
      return MaterialPageRoute(
          builder: (context) => AddAddressScreen(), settings: settings);
    case selectToWhoRoute:
      return MaterialPageRoute(
          builder: (context) => SelectToWhoScreen(), settings: settings);
    case addPaymentMethodRoute:
      return MaterialPageRoute(
          builder: (context) => AddPaymentMethodScreen(), settings: settings);
    case confirmOrderRoute:
      return MaterialPageRoute(
          builder: (context) => ConfirmOrderScreen(), settings: settings);
    case leaveMessageRoute:
      return MaterialPageRoute(
          builder: (context) => LeaveMessageScreen(), settings: settings);
    case congratulationRoute:
      return MaterialPageRoute(
          builder: (context) => CongratulationsScreen(), settings: settings);
    case trackOrderRoute:
      return MaterialPageRoute(
          builder: (context) => TrackOrderScreen(), settings: settings);
    case chooseFrameRoute:
      return MaterialPageRoute(
          builder: (context) => ChooseFrameScreen(), settings: settings);
    case loginRoute:
      return MaterialPageRoute(
          builder: (context) => LoginScreen(), settings: settings);
      case registerRoute:
      return MaterialPageRoute(
          builder: (context) => RegisterScreen(), settings: settings);

    default:
      return MaterialPageRoute(
          builder: (context) => HomeView(), settings: settings);
  }
}
