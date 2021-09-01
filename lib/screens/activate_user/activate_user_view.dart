import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'activate_user_desktop.dart';
import 'activate_user_mobile.dart';

class ActivateUserScreen extends StatelessWidget {
  final String phoneNumber;
  const ActivateUserScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: ActivateUserScreenMobile(phoneNumber: phoneNumber),
        landscape: ActivateUserScreenMobile(phoneNumber: phoneNumber),
      ),
      tablet: OrientationLayout(
        portrait: ActivateUserScreenDesktop(phoneNumber: phoneNumber),
        landscape: ActivateUserScreenDesktop(phoneNumber: phoneNumber),
      ),
      desktop: OrientationLayout(
        landscape: ActivateUserScreenDesktop(phoneNumber: phoneNumber),
        portrait: ActivateUserScreenDesktop(phoneNumber: phoneNumber),
      ),
    );
  }
}
