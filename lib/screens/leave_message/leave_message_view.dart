import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'leave_message_viewmodel.dart';

class LeaveMessageScreen extends StatelessWidget {
  const LeaveMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: LeaveMessageMobile(),
        landscape: LeaveMessageMobile(),
      ),
      tablet: OrientationLayout(
        portrait: LeaveMessageMobile(),
        landscape: LeaveMessageMobile(),
      ),
      desktop: OrientationLayout(
        landscape: LeaveMessageMobile(),
        portrait: LeaveMessageMobile(),
      ),
    );
  }
}

class LeaveMessageMobile extends StatelessWidget {
  const LeaveMessageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LeaveMessageViewModel>(
        create: (_) => LeaveMessageViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(title: S.of(context).leaveMessage),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 35),
                    Image(
                      height: 150,
                      image: AssetImage('assets/images/leave_message.png'),
                    ),
                    SizedBox(height: 25),
                    Text(
                      S.of(context).messageToYourDear,
                      style: TextStyle(fontSize: 26, color: Color(0xFF737888)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
          GradientButton(
              text: S.of(context).continueBTN,
              onTap: context.read<LeaveMessageViewModel>().continueAction)
        ],
      ),
    );
  }
}
