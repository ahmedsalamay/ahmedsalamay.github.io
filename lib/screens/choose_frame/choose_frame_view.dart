import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'choose_frame_desktop.dart';
import 'choose_frame_mobile.dart';

class ChooseFrameScreen extends StatelessWidget {
  const ChooseFrameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: const ChooseFrameMobile(),
        landscape: const ChooseFrameMobile(),
      ),
      tablet: OrientationLayout(
        portrait: const ChooseFrameDesktop(),
        landscape: const ChooseFrameDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: const ChooseFrameDesktop(),
        portrait: const ChooseFrameDesktop(),
      ),
    );
  }
}
