import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'login_desktop.dart';
import 'login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: LoginScreenMobile(),
        landscape: LoginScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: LoginScreenDesktop(),
        landscape: LoginScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: LoginScreenDesktop(),
        portrait: LoginScreenDesktop(),
      ),
    );
  }
}
