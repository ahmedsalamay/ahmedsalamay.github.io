import 'package:fimto_frame/models/order_status.dart';
import 'package:fimto_frame/screens/activate_user/activate_user_desktop.dart';
import 'package:fimto_frame/screens/activate_user/activate_user_view.dart';
import 'package:fimto_frame/screens/add_address/add_address_view.dart';
import 'package:fimto_frame/screens/add_payment_method/add_payment_method_view.dart';
import 'package:fimto_frame/screens/choose_frame/choose_frame_view.dart';
import 'package:fimto_frame/screens/confirm_order/confirm_order_view.dart';
import 'package:fimto_frame/screens/congratulation/congratulation_view.dart';
import 'package:fimto_frame/screens/current_orders/current_orders_view.dart';
import 'package:fimto_frame/screens/home/home_view.dart';
import 'package:fimto_frame/screens/instagram_picker/instagram_picker_view.dart';
import 'package:fimto_frame/screens/leave_message/leave_message_view.dart';
import 'package:fimto_frame/screens/login/login_view.dart';
import 'package:fimto_frame/screens/onbording/onbording.dart';
import 'package:fimto_frame/screens/register/register_view.dart';
import 'package:fimto_frame/screens/select_to_who/select_to_who_view.dart';
import 'package:fimto_frame/screens/splash/splash_view.dart';
import 'package:fimto_frame/screens/track_order/track_order_view.dart';
import 'package:flutter/material.dart';
import 'router_names.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: settings);

    case onBoardRoute:
      return MaterialPageRoute(
          builder: (context) => const OnBoardView(), settings: settings);

    case homeRoute:
      return MaterialPageRoute(
          builder: (context) => const HomeView(), settings: settings);

    case addAddressRoute:
      return MaterialPageRoute(
          builder: (context) => const AddAddressScreen(), settings: settings);

    case selectToWhoRoute:
      return MaterialPageRoute(
          builder: (context) => const SelectToWhoScreen(), settings: settings);

    case addPaymentMethodRoute:
      return MaterialPageRoute(
          builder: (context) => const AddPaymentMethodScreen(),
          settings: settings);

    case confirmOrderRoute:
      return MaterialPageRoute(
          builder: (context) => const ConfirmOrderScreen(), settings: settings);

    case leaveMessageRoute:
      return MaterialPageRoute(
          builder: (context) => const LeaveMessageScreen(), settings: settings);

    case congratulationRoute:
      return MaterialPageRoute(
          builder: (context) => const CongratulationsScreen(),
          settings: settings);

    case trackOrderRoute:
      return MaterialPageRoute(
          builder: (context) =>
              TrackOrderScreen(order: settings.arguments as OrderStatus),
          settings: settings);

    case chooseFrameRoute:
      return MaterialPageRoute(
          builder: (context) => const ChooseFrameScreen(), settings: settings);

    case loginRoute:
      return MaterialPageRoute(
          builder: (context) => LoginScreen(
              isComingFromGuest: settings.arguments != null
                  ? settings.arguments as bool
                  : false),
          settings: settings);
          
    case registerRoute:
      return MaterialPageRoute(
          builder: (context) => const RegisterScreen(), settings: settings);

    case currentOrdersRoute:
      return MaterialPageRoute(
          builder: (context) => const CurrentOrdersScreen(),
          settings: settings);
    case activateUserRoute:
      return MaterialPageRoute(
          builder: (context) =>
              ActivateUserScreen(phoneNumber: settings.arguments as String),
          settings: settings);

    case instaPickerRoute:
      return MaterialPageRoute(
          builder: (context) => InstgramPicker(
                code: (settings.arguments) as String,
              ),
          settings: settings);

    default:
      return MaterialPageRoute(
          builder: (context) => const HomeView(), settings: settings);
  }
}
