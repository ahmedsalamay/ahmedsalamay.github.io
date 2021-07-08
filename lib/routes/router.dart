import 'package:fimto_frame/screens/add_address/add_address_view.dart';
import 'package:fimto_frame/screens/home/home_view.dart';
import 'package:fimto_frame/screens/onbording/onbording.dart';
import 'package:fimto_frame/screens/splash/splash_view.dart';
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

    default:
      return MaterialPageRoute(
          builder: (context) => HomeView(), settings: settings);
  }
}
