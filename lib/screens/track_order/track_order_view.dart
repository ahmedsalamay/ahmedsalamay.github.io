import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/order_status.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'track_order_viewmodel.dart';

class TrackOrderScreen extends StatelessWidget {
  final OrderStatus order;
  const TrackOrderScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: TrackOrderMobile(order: order),
        landscape: TrackOrderMobile(order: order),
      ),
      tablet: OrientationLayout(
        portrait: TrackOrderMobile(order: order),
        landscape: TrackOrderMobile(order: order),
      ),
      desktop: OrientationLayout(
        landscape: TrackOrderMobile(order: order),
        portrait: TrackOrderMobile(order: order),
      ),
    );
  }
}

class TrackOrderMobile extends StatelessWidget {
  final OrderStatus order;

  const TrackOrderMobile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrackOrderViewModel>(
        create: (_) => TrackOrderViewModel(order: order),
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
    var vm = context.read<TrackOrderViewModel>();
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
                      color: vm.order.status >= OrderStatesEn.Accecpted.index
                          ? FimtoColors.successColor
                          : Colors.transparent),
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
