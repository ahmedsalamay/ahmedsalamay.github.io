import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/screens/select_to_who/select_to_who_viewmodel.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SelectToWhoScreen extends StatelessWidget {
  const SelectToWhoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: SelectToWhoMobile(),
        landscape: SelectToWhoMobile(),
      ),
      tablet: OrientationLayout(
        portrait: SelectToWhoMobile(),
        landscape: SelectToWhoMobile(),
      ),
      desktop: OrientationLayout(
        landscape: SelectToWhoMobile(),
        portrait: SelectToWhoMobile(),
      ),
    );
  }
}

class SelectToWhoMobile extends StatelessWidget {
  const SelectToWhoMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectToWhoViewModel>(
        create: (_) => SelectToWhoViewModel(),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(title: S.of(context).selectToWho),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 35),
                          Text(
                            S.of(context).selectCreateFrames,
                            style: TextStyle(
                                fontSize: 26, color: Color(0xFF737888)),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 25),
                          _GiftCard(selected: false),
                          _ForMeCard(selected: false)
                        ],
                      ),
                    ),
                  ),
                ),
                GradientButton(text: S.of(context).continueBTN, onTap: () {})
              ],
            ),
          ),
        ));
  }
}

class _GiftCard extends StatelessWidget {
  final bool selected;
  const _GiftCard({required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.read<SelectToWhoViewModel>().onGiftSelected,
      child: Container(
        child: Column(
          children: [
            Placeholder(
              fallbackHeight: 120,
              fallbackWidth: 50,
            ),
            SizedBox(height: 6),
            _Choice(
              selected: context.watch<SelectToWhoViewModel>().giftSelected,
              label: S.of(context).gift,
            ),
            SizedBox(height: 6),
            Text(
              S.of(context).forPerson,
              style: TextStyle(fontSize: 16, color: Color(0xFFbabdc5)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              S.of(context).noAdditionalExpenses,
              style: TextStyle(fontSize: 16, color: Color(0xFFeff0f2)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ForMeCard extends StatelessWidget {
  final bool selected;
  const _ForMeCard({required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.read<SelectToWhoViewModel>().onForMeSelected,
      child: Container(
        child: Column(
          children: [
            Placeholder(
              fallbackHeight: 120,
              fallbackWidth: 50,
            ),
            SizedBox(height: 6),
            _Choice(
              selected: context.watch<SelectToWhoViewModel>().forMeSelected,
              label: S.of(context).forMe,
            ),
            SizedBox(height: 6),
            Text(
              S.of(context).decorateMyWall,
              style: TextStyle(fontSize: 16, color: Color(0xFFbabdc5)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  final String label;
  final bool selected;

  const _Choice({Key? key, required this.label, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: Color(0xFFe4e4e4), borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF62687a),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Icon(Icons.radio_button_checked,
              color: selected ? Colors.green : Colors.grey)
        ],
      ),
    );
  }
}
