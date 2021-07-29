import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'add_address_desktop.dart';
import 'add_address_mobile.dart';


class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: AddAddressScreenMobile(),
        landscape: AddAddressScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: AddAddressScreenDesktop(),
        landscape: AddAddressScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: AddAddressScreenDesktop(),
        portrait: AddAddressScreenDesktop(),
      ),
    );
  }
}


