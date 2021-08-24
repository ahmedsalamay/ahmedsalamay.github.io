import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'choose_frame_desktop.dart';
import 'choose_frame_mobile.dart';

class ChooseFrameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: ChooseFrameMobile(),
        landscape: ChooseFrameMobile(),
      ),
      tablet: OrientationLayout(
        portrait: ChooseFrameDesktop(),
        landscape: ChooseFrameDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: ChooseFrameDesktop(),
        portrait: ChooseFrameDesktop(),
      ),
    );
  }
}
