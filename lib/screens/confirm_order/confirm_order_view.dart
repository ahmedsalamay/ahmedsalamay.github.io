import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'confirm_order_desktop.dart';
import 'confirm_order_mobile.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: const ConfirmOrderScreenMobile(),
        landscape: const ConfirmOrderScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: const ConfirmOrderScreenDesktop(),
        landscape: const ConfirmOrderScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: const ConfirmOrderScreenDesktop(),
        portrait: const ConfirmOrderScreenDesktop(),
      ),
    );
  }
}
