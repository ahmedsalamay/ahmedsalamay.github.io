import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'current_orders_desktop.dart';
import 'current_orders_mobile.dart';

class CurrentOrdersScreen extends StatelessWidget {
  const CurrentOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: CurrentOrdersScreenMobile(),
        landscape: CurrentOrdersScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: CurrentOrdersScreenDesktop(),
        landscape: CurrentOrdersScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: CurrentOrdersScreenDesktop(),
        portrait: CurrentOrdersScreenDesktop(),
      ),
    );
  }
}
