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
        portrait: const AddAddressScreenMobile(),
        landscape: const AddAddressScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: const AddAddressScreenDesktop(),
        landscape: const AddAddressScreenDesktop(),
      ),
      desktop: OrientationLayout(
        landscape: const AddAddressScreenDesktop(),
        portrait: const AddAddressScreenDesktop(),
      ),
    );
  }
}
