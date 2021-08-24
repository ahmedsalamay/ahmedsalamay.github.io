import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'track_order_viewmodel.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: const TrackOrderMobile(),
        landscape: const TrackOrderMobile(),
      ),
      tablet: OrientationLayout(
        portrait: const TrackOrderMobile(),
        landscape: const TrackOrderMobile(),
      ),
      desktop: OrientationLayout(
        landscape: const TrackOrderMobile(),
        portrait: const TrackOrderMobile(),
      ),
    );
  }
}

class TrackOrderMobile extends StatelessWidget {
  const TrackOrderMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrackOrderViewModel>(
        create: (_) => TrackOrderViewModel(),
        child: const Scaffold(
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
        //mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(title: S.of(context).trackYourOrder),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SizedBox(height: 35),
                  Image(
                    height: MediaQuery.of(context).size.height * 0.25,
                    image: const AssetImage('assets/images/confirm.png'),
                  ),
                  const SizedBox(height: 15),
                  const _Stepper()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.successColor),
                  child: const Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                const SizedBox(width: 15),
                Text(
                  S.of(context).orderIsConfirmed,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 22),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 30,
              child: const VerticalDivider(
                thickness: 4,
                color: FimtoColors.successColor,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.successColor),
                  child: const Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                const SizedBox(width: 15),
                Text(
                  S.of(context).processing,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 22),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 30,
              child: const VerticalDivider(
                thickness: 4,
                color: FimtoColors.successColor,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.successColor),
                  child: const Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                const SizedBox(width: 15),
                Text(
                  S.of(context).deliveredForShipment,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 22),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 30,
              child: const VerticalDivider(
                thickness: 4,
                color: FimtoColors.successColor,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.successColor),
                  child: const Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                const SizedBox(width: 15),
                Text(
                  S.of(context).delivered,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 22),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
