import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'congratulation_desktop.dart';
import 'congratulation_mobile.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: const CongratulationsMobile(),
        landscape: const CongratulationsMobile(),
      ),
      tablet: OrientationLayout(
        portrait: const CongratulationsDesktop(),
        landscape: const CongratulationsDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: const CongratulationsDesktop(),
        portrait: const CongratulationsDesktop(),
      ),
    );
  }
}
