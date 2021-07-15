import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'add_payment_method_viewmodel.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: AddPaymentMethodScreenMobile(),
        landscape: AddPaymentMethodScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: AddPaymentMethodScreenMobile(),
        landscape: AddPaymentMethodScreenMobile(),
      ),
      desktop: OrientationLayout(
        landscape: AddPaymentMethodScreenMobile(),
        portrait: AddPaymentMethodScreenMobile(),
      ),
    );
  }
}

class AddPaymentMethodScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPaymentMethodViewModel>(
        create: (_) => AddPaymentMethodViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: CustomDrawer(),
          body: _Body(),
        ));
  }
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    context.read<AddPaymentMethodViewModel>().initAsync();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddPaymentMethodViewModel>();
    return SafeArea(
      child: Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomAppBar(title: S.of(context).addPaymentMethod),
                _Stepper(),
                Expanded(
                  child: SingleChildScrollView(
                    child: _PaymentMethods(),
                  ),
                ),
                GradientButton(
                  text: S.of(context).confirmPaymentMethod,
                  onTap: () => Get.toNamed(confirmOrderRoute),
                )
              ],
            ),
          )),
    );
  }
}

class _PaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddPaymentMethodViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          S.of(context).choosePaymentMethod,
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(height: 15),
        _PaymentButton(
          onTap: () =>
              vm.selectPaymentMethodAction(paymentMethods.VodafoneCash),
          text: 'Vodafone Cash',
          icon: 'vodafone',
          isSelected: vm.isVodafoneSelected(),
        ),
        _PaymentButton(
          onTap: () =>
              vm.selectPaymentMethodAction(paymentMethods.EtisalatCash),
          text: 'Etisalat Cash',
          icon: 'etisalat',
          isSelected: vm.isEtisalatSelected(),
        ),
        _PaymentButton(
          onTap: () => vm.selectPaymentMethodAction(paymentMethods.OrangeCash),
          text: 'Orange Cash',
          icon: 'orange',
          isSelected: vm.isOrangeSelected(),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            S.of(context).pleaseTransferAmountTo,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            '+201090928586',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            S.of(context).paymentConfirmAutomatically,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.primaryColor),
                  child: Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Expanded(
                    child:
                        Divider(thickness: 4, color: FimtoColors.primaryColor)),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.primaryColor),
                  child: Center(
                      child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  )),
                ),
                Expanded(child: Divider(thickness: 4)),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: FimtoColors.dividerColor, width: 3)),
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                          color: FimtoColors.dividerColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).addAddress,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                S.of(context).payment,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                S.of(context).confirmation,
                style: TextStyle(
                    color: FimtoColors.dividerColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _PaymentButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String icon;
  final String text;
  const _PaymentButton({
    required this.onTap,
    required this.isSelected,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(4),
          height: 60,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xffffe2db) : Colors.white,
            border: Border.all(
              color: Color(0xffededed),
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/${icon}.png'),
                ),
              ),
              SizedBox(width: 10),
              Text(text,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w900 : FontWeight.w400)),
              Spacer(),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isSelected ? Color(0xffff3400) : Color(0xffd4d3d2)),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
