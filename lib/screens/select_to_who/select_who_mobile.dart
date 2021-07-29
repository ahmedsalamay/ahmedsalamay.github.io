import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/screens/select_to_who/select_to_who_viewmodel.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';

class SelectToWhoMobile extends StatelessWidget {
  const SelectToWhoMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectToWhoViewModel>(
        create: (_) => SelectToWhoViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: CustomDrawer(),
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
                    SizedBox(height: 35),
                    Text(
                      S.of(context).selectCreateFrames,
                      style: TextStyle(fontSize: 26, color: Color(0xFF737888)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    GiftCard(selected: false),
                    ForMeCard(selected: false)
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: vm.isAnySelected,
            child: GradientButton(
                text: S.of(context).continueBTN,
                onTap: context.read<SelectToWhoViewModel>().continueAction),
          )
        ],
      ),
    );
  }
}
