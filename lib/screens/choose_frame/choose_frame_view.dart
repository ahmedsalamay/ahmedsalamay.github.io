import 'dart:typed_data';
import 'package:fimto_frame/responsive/responsive_layout.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'choose_frame_desktop.dart';
import 'choose_frame_mobile.dart';

class ChooseFrameScreen extends StatelessWidget {
  final List<Uint8List> pickedFile;
  const ChooseFrameScreen({Key? key, required this.pickedFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: ChooseFrameMobile(pickedFile: pickedFile),
        landscape: ChooseFrameMobile(pickedFile: pickedFile),
      ),
      tablet: OrientationLayout(
        portrait: ChooseFrameDesktop(pickedFile: pickedFile),
        landscape: ChooseFrameDesktop(pickedFile: pickedFile),
      ),
      desktop: OrientationLayout(
        landscape: ChooseFrameDesktop(pickedFile: pickedFile),
        portrait: ChooseFrameDesktop(pickedFile: pickedFile),
      ),
    );
  }
}
