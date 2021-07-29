import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'home_desktop.dart';
import 'home_mobile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: HomeViewMobile(),
        landscape: HomeViewMobile(),
      ),
      tablet: OrientationLayout(
        portrait: HomeViewDesktop(),
        landscape: HomeViewDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: HomeViewDesktop(),
        portrait: HomeViewDesktop(),
      ),
    );
  }
}
