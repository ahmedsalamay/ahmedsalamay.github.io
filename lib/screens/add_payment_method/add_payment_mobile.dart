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
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'add_payment_method_viewmodel.dart';

class AddPaymentMethodScreenMobile extends StatelessWidget {
  const AddPaymentMethodScreenMobile({Key? key}) : super(key: key);

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
              ? const CustomDrawer()
              : null,
          drawer: language.currentLocale.languageCode == 'ar'
              ? const CustomDrawer()
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
      child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              CustomAppBar(title: S.of(context).addPaymentMethod),
              const _Stepper(),
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

class _PaymentMethods extends StatelessWidget {
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
          const SizedBox(height: 15),
          FutureBuilder<List<PaymentsMethods>>(
            future: vm.paymentFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data!
                        .map((e) => _PaymentButton(
                              paymentsMethod: e,
                            ))
                        .toList());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error happened'));
              }
              return Shimmer(
                duration: const Duration(milliseconds: 500), //Default value
                interval: const Duration(
                    milliseconds: 500), //Default value: Duration(seconds: 0)
                color: Colors.grey.shade600, //Default value
                colorOpacity: 0.3, //Default value
                enabled: true, //Default value
                direction: const ShimmerDirection.fromLTRB(), //Default Value
                child: Container(
                  color: Colors.grey.shade300,
                  height: 350,
                  width: 350,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          vm.selectedPaymentMethods != null
              ? Center(
                  child: Text(
                    S.of(context).pleaseTransferAmountTo,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          vm.selectedPaymentMethods != null
              ? Center(
                  child: SelectableText(
                    vm.selectedPaymentMethods!.phoneNumber,
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          Center(
            child: Text(
              S.of(context).paymentConfirmAutomatically,
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 6),
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
      padding: const EdgeInsets.all(15),
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
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const Expanded(
                    child:
                        Divider(thickness: 4, color: FimtoColors.primaryColor)),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FimtoColors.primaryColor),
                  child: const Center(
                      child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  )),
                ),
                const Expanded(child: Divider(thickness: 4)),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: FimtoColors.dividerColor, width: 3)),
                  child: const Center(
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
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                S.of(context).payment,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                S.of(context).confirmation,
                style: const TextStyle(
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
          padding: const EdgeInsets.all(4),
          height: 60,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: vm.selectedPaymentMethods?.companyName ==
                    paymentsMethod.companyName
                ? const Color(0xffffe2db)
                : Colors.white,
            border: Border.all(
              color: const Color(0xffededed),
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.memory(base64Decode(paymentsMethod.image)),
              ),
              const SizedBox(width: 10),
              Text(paymentsMethod.companyName,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: 16,
                      fontWeight: vm.selectedPaymentMethods?.companyName ==
                              paymentsMethod.companyName
                          ? FontWeight.w900
                          : FontWeight.w400)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: vm.selectedPaymentMethods?.companyName ==
                            paymentsMethod.companyName
                        ? const Color(0xffff3400)
                        : const Color(0xffd4d3d2)),
                child: const Icon(
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
    var vm = context.watch<AddPaymentMethodViewModel>();
    return vm.isPromoCodeLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              //strokeWidth: 2,
            ),
          )
        : InkWell(
            onTap: () => vm.applyPromoCode(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 48,
                child: Container(
                  child: Center(
                    child: Text(
                      vm.isPromoCodeActivated ? 'activated' : 'redeem',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: vm.isPromoCodeActivated
                          ? Colors.green
                          : FimtoColors.primaryColor),
                ),
              ),
            ),
          );
  }
}

class _PromoCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddPaymentMethodViewModel>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
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
                        contentPadding: const EdgeInsets.all(6),
                        hintText: 'enterPromoCode',
                        hintStyle: const TextStyle(fontSize: 16),
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
            const SizedBox(height: 4),
            Visibility(
              visible: vm.isPromoCodeActivated,
              child: const Text(
                'promoCodeAdded',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
