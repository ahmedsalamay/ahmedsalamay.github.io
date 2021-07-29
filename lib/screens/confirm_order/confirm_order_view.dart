import 'package:fimto_frame/generated/l10n.dart';
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
        portrait: ConfirmOrderScreenMobile(),
        landscape: ConfirmOrderScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: ConfirmOrderScreenDesktop(),
        landscape: ConfirmOrderScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: ConfirmOrderScreenDesktop(),
        portrait: ConfirmOrderScreenDesktop(),
      ),
    );
  }
}
