import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'register_desktop.dart';
import 'register_mobile.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: RegisterScreenMobile(),
        landscape: RegisterScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: RegisterScreenDesktop(),
        landscape: RegisterScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: RegisterScreenDesktop(),
        portrait: RegisterScreenDesktop(),
      ),
    );
  }
}
