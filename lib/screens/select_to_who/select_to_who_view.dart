import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/screens/select_to_who/select_who_mobile.dart';
import 'package:flutter/material.dart';

import 'select_who_desktop.dart';

class SelectToWhoScreen extends StatelessWidget {
  const SelectToWhoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: SelectToWhoMobile(),
        landscape: SelectToWhoMobile(),
      ),
      tablet: OrientationLayout(
        portrait: SelectToWhoDesktop(),
        landscape: SelectToWhoDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: SelectToWhoDesktop(),
        portrait: SelectToWhoDesktop(),
      ),
    );
  }
}
