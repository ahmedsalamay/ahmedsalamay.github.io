import 'package:fimto_frame/responsive/responsive_layout.dart';

import 'package:flutter/material.dart';

import 'leave_message_desktop.dart';
import 'leave_message_mobile.dart';

class LeaveMessageScreen extends StatelessWidget {
  const LeaveMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: const LeaveMessageMobile(),
        landscape: const LeaveMessageMobile(),
      ),
      tablet: OrientationLayout(
        portrait: const LeaveMessageDesktop(),
        landscape: const LeaveMessageDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: const LeaveMessageDesktop(),
        portrait: const LeaveMessageDesktop(),
      ),
    );
  }
}
