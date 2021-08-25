import 'dart:convert';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'add_payment_method_viewmodel.dart';

class AddPaymentMethodScreenDesktop extends StatelessWidget {
  const AddPaymentMethodScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPaymentMethodViewModel>(
        create: (_) => AddPaymentMethodViewModel(
            connectionService: context.read<ConnectionService>(),
            messageService: context.read<MessageService>(),
            orderRepository: context.read<OrderRepository>(),
            order: context.read<Order>()),
        child: Scaffold(
          backgroundColor: Colors.white,
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
          width: double.infinity,
          child: Row(
            children: [
              const Expanded(flex: 1, child: _Stepper()),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _PaymentMethods(),
                    const SizedBox(height: 40),
                    SizedBox(
                        width: 230,
                        child: Visibility(
                          visible: vm.selectedPaymentMethods != null,
                          child: GradientButton(
                            text: S.of(context).confirmPaymentMethod,
                            onTap: () => vm.onConfirmPaymentMethodAction(),
                          ),
                        ))
                  ],
                ),
              ),
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Text(
            S.of(context).choosePaymentMethod,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 35),
          FutureBuilder<List<PaymentsMethods>>(
            future: paymentFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data!
                          .map((e) => _PaymentButton(
                                paymentsMethod: e,
                              ))
                          .toList()),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error happened'));
              }
              return const Center(
                child: PlayStoreShimmer(
                  hasBottomFirstLine: true,
                ),
              );
            },
          ),
          const SizedBox(height: 45),
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
          )
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
      constraints: const BoxConstraints(maxWidth: 300),
      height: double.infinity,
      color: const Color(0xFFf9f9f9),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            constraints: const BoxConstraints(maxHeight: 400),
            child: Column(
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
                    color: Colors.white,
                    size: 30,
                  )),
                ),
                const SizedBox(height: 12),
                const Expanded(
                    child: VerticalDivider(
                  thickness: 4,
                  color: FimtoColors.successColor,
                )),
                const SizedBox(height: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: FimtoColors.dividerColor, width: 3)),
                  child: const Center(
                      child: Text(
                    '2',
                    style: TextStyle(
                        color: FimtoColors.dividerColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  )),
                ),
                const SizedBox(height: 12),
                const Expanded(child: VerticalDivider(thickness: 4)),
                const SizedBox(height: 12),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            constraints: const BoxConstraints(maxHeight: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).addAddress,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  S.of(context).payment,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  S.of(context).confirmation,
                  style: const TextStyle(
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
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
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
