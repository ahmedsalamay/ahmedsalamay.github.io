import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/screens/congratulation/congratulation_desktop.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'confirm_order_viewmodel.dart';

class ConfirmOrderScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmOrderViewModel>(
        create: (_) => ConfirmOrderViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConfirmOrderViewModel>();
    return SafeArea(
      child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(flex: 1, child: _Stepper()),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _OrderSummary(),
                    SizedBox(height: 60),
                    SizedBox(
                      width: 130,
                      child: GradientButton(
                        text: S.of(context).confirmOrder,
                        //onTap: () => Get.toNamed(congratulationRoute),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return CongratulationsDesktop();
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ConfirmOrderViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(
            S.of(context).orderSummary,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 15),
          _OrderSummaryItem(
            title: S.of(context).address,
            value: 'sherry st..',
          ),
          _OrderSummaryItem(
            title: S.of(context).paymentMethod,
            value: 'Vodafone cash',
          ),
          _OrderSummaryItem(
            title: S.of(context).deliveryTime,
            value: '27 May 2021, 22:00 Am',
          ),
          _PriceSummary()
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
      constraints: BoxConstraints(maxWidth: 300),
      height: double.infinity,
      color: Color(0xFFf9f9f9),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            constraints: BoxConstraints(maxHeight: 400),
            child: Column(
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
                    color: Colors.white,
                    size: 30,
                  )),
                ),
                SizedBox(height: 12),
                Expanded(
                    child: VerticalDivider(
                  thickness: 4,
                  color: FimtoColors.successColor,
                )),
                SizedBox(height: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.successColor),
                  child: Center(
                      child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  )),
                ),
                SizedBox(height: 12),
                Expanded(
                    child: VerticalDivider(
                  thickness: 4,
                  color: FimtoColors.successColor,
                )),
                SizedBox(height: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.primaryColor),
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            constraints: BoxConstraints(maxHeight: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).addAddress,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  S.of(context).payment,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  S.of(context).confirmation,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OrderSummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const _OrderSummaryItem({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 19),
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              value,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            decoration: BoxDecoration(
                color: Color(0xFFe4e4e4),
                borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}

class _PriceSummary extends StatelessWidget {
  const _PriceSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
      color: Colors.white,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 12),
          child: Column(
            children: [
              _PruceSummaryRowItem('3 Frames', '269LE'),
              _PruceSummaryRowItem('Extra Frame', '74LE'),
              _PruceSummaryRowItem('Delivery', 'Free'),
              Divider(),
              _PriceTotal('Total', '343LE'),
            ],
          )),
    );
  }
}

class _PruceSummaryRowItem extends StatelessWidget {
  final String title;
  final String value;

  const _PruceSummaryRowItem(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF737888),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF737888),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PriceTotal extends StatelessWidget {
  final String title;
  final String value;

  const _PriceTotal(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
