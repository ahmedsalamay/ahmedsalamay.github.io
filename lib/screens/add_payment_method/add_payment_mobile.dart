import 'dart:convert';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'add_payment_method_viewmodel.dart';

class AddPaymentMethodScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();

    return ChangeNotifierProvider<AddPaymentMethodViewModel>(
        create: (_) => AddPaymentMethodViewModel(
            connectionService: context.read<ConnectionService>(),
            messageService: context.read<MessageService>(),
            orderRepository: context.read<OrderRepository>(),
            order: context.read<Order>()),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: language.currentLocale.languageCode == 'en'
              ? CustomDrawer()
              : null,
          drawer: language.currentLocale.languageCode == 'ar'
              ? CustomDrawer()
              : null,
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddPaymentMethodViewModel>();
    return SafeArea(
      child: Container(
          height: double.infinity,
          child: Column(
            children: [
              CustomAppBar(title: S.of(context).addPaymentMethod),
              _Stepper(),
              Expanded(
                child: SingleChildScrollView(
                  child: _PaymentMethods(),
                ),
              ),
              Visibility(
                visible: vm.selectedPaymentMethods != null,
                child: GradientButton(
                  text: S.of(context).confirmPaymentMethod,
                  onTap: () => vm.onConfirmPaymentMethodAction(),
                ),
              )
            ],
          )),
    );
  }
}

class _PaymentMethods extends StatefulWidget {
  @override
  __PaymentMethodsState createState() => __PaymentMethodsState();
}

class __PaymentMethodsState extends State<_PaymentMethods> {
  late Future<List<PaymentsMethods>> paymentFuture;
  @override
  void initState() {
    super.initState();
    paymentFuture =
        context.read<AddPaymentMethodViewModel>().loadPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddPaymentMethodViewModel>();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).choosePaymentMethod,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 15),
          FutureBuilder<List<PaymentsMethods>>(
            future: paymentFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data!
                        .map((e) => _PaymentButton(
                              paymentsMethod: e,
                            ))
                        .toList());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error happened'));
              }
              return PlayStoreShimmer(
                hasBottomFirstLine: true,
              );
            },
          ),
          SizedBox(height: 10),
          vm.selectedPaymentMethods != null
              ? Center(
                  child: Text(
                    S.of(context).pleaseTransferAmountTo,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox(),
          SizedBox(height: 10),
          vm.selectedPaymentMethods != null
              ? Center(
                  child: SelectableText(
                    vm.selectedPaymentMethods!.phoneNumber,
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox(),
          SizedBox(height: 10),
          Center(
            child: Text(
              S.of(context).paymentConfirmAutomatically,
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 6),
          _PromoCode()
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
      padding: EdgeInsets.all(15),
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
  final PaymentsMethods paymentsMethod;

  const _PaymentButton({
    required this.paymentsMethod,
  });

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddPaymentMethodViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () => vm.onPaymentMethodSelection(paymentsMethod),
        child: Container(
          padding: EdgeInsets.all(4),
          height: 60,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: vm.selectedPaymentMethods?.companyName ==
                    paymentsMethod.companyName
                ? Color(0xffffe2db)
                : Colors.white,
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
                child: Image.memory(base64Decode(paymentsMethod.image)),
              ),
              SizedBox(width: 10),
              Text(paymentsMethod.companyName,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: 16,
                      fontWeight: vm.selectedPaymentMethods?.companyName ==
                              paymentsMethod.companyName
                          ? FontWeight.w900
                          : FontWeight.w400)),
              Spacer(),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: vm.selectedPaymentMethods?.companyName ==
                            paymentsMethod.companyName
                        ? Color(0xffff3400)
                        : Color(0xffd4d3d2)),
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

class _PromoCodeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<AddPaymentMethodViewModel>(context);
    return InkWell(
      onTap: () => vm.applyPromoCode(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 48,
          child: Container(
            child: Center(
              child: vm.isPromoCodeLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Text(
                      vm.isPromoCodeActivated ? 'activated' : 'redeem',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color:
                    vm.isPromoCodeActivated ? Colors.green : Colors.deepOrange),
          ),
        ),
      ),
    );
  }
}

class _PromoCode extends StatelessWidget {
  bool isLoading = false;
  bool isValidCode = false;

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<AddPaymentMethodViewModel>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: Flexible(
        fit: FlexFit.loose,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: new BorderRadius.all(
              new Radius.circular(8.0),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        onChanged: (value) {
                          // if (value.isNotEmpty && value != "") {
                          //   vm.changePromoCodeButtonEnabled(true);
                          // } else {
                          //   vm.changePromoCodeButtonEnabled(false);
                          // }
                          vm.promoCode = value;
                        },
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          hintText: 'enterPromoCode',
                          hintStyle: TextStyle(fontSize: 16),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: vm.isPromoCodeActivated
                                    ? Colors.green
                                    : Colors.white,
                                width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: _PromoCodeButton())
                ],
              ),
              SizedBox(height: 4),
              Visibility(
                visible: vm.isPromoCodeActivated,
                child: Text(
                  'promoCodeAdded',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
