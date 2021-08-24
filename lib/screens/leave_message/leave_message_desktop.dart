import 'package:fimto_frame/models/language.dart';
import 'package:provider/provider.dart';
import 'leave_message_viewmodel.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

class LeaveMessageDesktop extends StatelessWidget {
  const LeaveMessageDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();
    return ChangeNotifierProvider<LeaveMessageViewModel>(
        create: (_) => LeaveMessageViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: language.currentLocale.languageCode == 'en'
              ? const CustomDrawer()
              : null,
          drawer: language.currentLocale.languageCode == 'ar'
              ? const CustomDrawer()
              : null,
          body: const _Body(),
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
                    const SizedBox(height: 35),
                    const Image(
                      height: 150,
                      image: AssetImage('assets/images/leave_message.png'),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      S.of(context).messageToYourDear,
                      style: const TextStyle(
                          fontSize: 26, color: Color(0xFF737888)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: GradientButton(
                text: S.of(context).continueBTN,
                onTap: context.read<LeaveMessageViewModel>().continueAction),
          )
        ],
      ),
    );
  }
}
