import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/screens/select_to_who/select_to_who_viewmodel.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';

class SelectToWhoDesktop extends StatelessWidget {
  const SelectToWhoDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();
    return ChangeNotifierProvider<SelectToWhoViewModel>(
        create: (_) => SelectToWhoViewModel(order: context.read<Order>()),
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
    var vm = context.watch<SelectToWhoViewModel>();
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(title: S.of(context).selectToWho),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 35),
                    Text(
                      S.of(context).selectCreateFrames,
                      style: const TextStyle(
                          fontSize: 26, color: Color(0xFF737888)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [GiftCard(), ForMeCard()],
                    )
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: vm.isAnySelected,
            child: SizedBox(
              width: 200,
              child: GradientButton(
                  text: S.of(context).continueBTN,
                  onTap: context.read<SelectToWhoViewModel>().continueAction),
            ),
          )
        ],
      ),
    );
  }
}
