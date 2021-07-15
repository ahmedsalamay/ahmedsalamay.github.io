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
        portrait: TrackOrderMobile(),
        landscape: TrackOrderMobile(),
      ),
      tablet: OrientationLayout(
        portrait: TrackOrderMobile(),
        landscape: TrackOrderMobile(),
      ),
      desktop: OrientationLayout(
        landscape: TrackOrderMobile(),
        portrait: TrackOrderMobile(),
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
                    image: AssetImage('assets/images/confirm.png'),
                  ),
                  SizedBox(height: 15),
                  _Stepper()
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
    return Container(
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
                  child: Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                SizedBox(width: 15),
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
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 30,
              child: VerticalDivider(
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
                  child: Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                SizedBox(width: 15),
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
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 30,
              child: VerticalDivider(
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
                  child: Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                SizedBox(width: 15),
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
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 30,
              child: VerticalDivider(
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
                  child: Center(
                      child: Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )),
                ),
                SizedBox(width: 15),
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
