import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'add_payment_desktop.dart';
import 'add_payment_mobile.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: AddPaymentMethodScreenMobile(),
        landscape: AddPaymentMethodScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: AddPaymentMethodScreenDesktop(),
        landscape: AddPaymentMethodScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: AddPaymentMethodScreenDesktop(),
        portrait: AddPaymentMethodScreenDesktop(),
      ),
    );
  }
}
