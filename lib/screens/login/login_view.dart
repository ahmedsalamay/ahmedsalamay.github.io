import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'login_desktop.dart';
import 'login_mobile.dart';

class LoginScreen extends StatelessWidget {
  final bool isComingFromGuest;
  const LoginScreen({Key? key, required this.isComingFromGuest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: LoginScreenMobile(isComingFromGuest: isComingFromGuest),
        landscape: LoginScreenMobile(isComingFromGuest: isComingFromGuest),
      ),
      tablet: OrientationLayout(
        portrait: LoginScreenDesktop(isComingFromGuest: isComingFromGuest),
        landscape: LoginScreenDesktop(isComingFromGuest: isComingFromGuest),
      ),
      desktop: OrientationLayout(
        landscape: LoginScreenDesktop(isComingFromGuest: isComingFromGuest),
        portrait: LoginScreenDesktop(isComingFromGuest: isComingFromGuest),
      ),
    );
  }
}
