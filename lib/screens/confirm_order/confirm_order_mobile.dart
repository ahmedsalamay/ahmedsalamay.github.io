import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'confirm_order_viewmodel.dart';

class ConfirmOrderScreenMobile extends StatelessWidget {
  const ConfirmOrderScreenMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmOrderViewModel>(
        create: (_) => ConfirmOrderViewModel(
            connectionService: context.read<ConnectionService>(),
            messageService: context.read<MessageService>(),
            orderRepository: context.read<OrderRepository>(),
            order: context.read<Order>()),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: const CustomDrawer(),
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConfirmOrderViewModel>();
    return SafeArea(
      child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              CustomAppBar(title: S.of(context).confirmYourOrder),
              const _Stepper(),
              Expanded(
                child: SingleChildScrollView(
                  child: _OrderSummary(),
                ),
              ),
              Visibility(
                  visible: vm.isLoading, child:const CircularProgressIndicator()),
              GradientButton(
                text: S.of(context).confirmOrder,
                onTap: () => vm.onConfirmOrderAction(),
              )
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
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            S.of(context).orderSummary,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 15),
          _OrderSummaryItem(
            title: S.of(context).address,
            value: vm.order.address!,
          ),
          _OrderSummaryItem(
            title: S.of(context).paymentMethod,
            value: vm.order.paymentMethod!,
          ),
          const _DatePicker(),
          const _PriceSummary()
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
      padding:const EdgeInsets.all(15),
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
                  child:const Center(
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
                  child:const Center(
                      child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  )),
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
                  child:const Center(
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
                style:const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                S.of(context).confirmation,
                style:const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              value,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            decoration: BoxDecoration(
                color:const Color(0xFFe4e4e4),
                borderRadius: BorderRadius.circular(15)),
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
    var vm = context.watch<ConfirmOrderViewModel>();
    return Container(
      height: 250.0,
      color: Colors.white,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft:  Radius.circular(15.0),
                  topRight:  Radius.circular(15.0))),
          child: Column(
            children: [
              _PruceSummaryRowItem(vm.packageSize + S.of(context).frames,
                  vm.packagePrice + S.of(context).le),
              Visibility(
                  //TODO Show Extra frame or not when no extra
                  visible: true, //vm.isExtraFrames,
                  child: _PruceSummaryRowItem(S.of(context).extraFrame,
                      vm.extraFramesPrice + S.of(context).le)),
              _PruceSummaryRowItem(S.of(context).delivery, vm.deliveryFees),
              _PruceSummaryRowItem(S.of(context).discount, vm.discount),
              const  Divider(),
              _PriceTotal(S.of(context).total, vm.total + S.of(context).le),
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
            style:const TextStyle(
                fontSize: 16,
                color: Color(0xFF737888),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style:const TextStyle(
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
            style:const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style:const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  const _DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ConfirmOrderViewModel>();
    return MaterialButton(
      onPressed: () => _showDatePicker(context),
      padding:const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).deliveryTime,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color:const Color(0xFFe4e4e4),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(Icons.calendar_today),
                const  SizedBox(width: 12),
                Text(
                  vm.deliveryDate ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    var vm = context.read<ConfirmOrderViewModel>();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(hours: 12)),
      firstDate: DateTime.now().add(const Duration(hours: 24)),
      lastDate: DateTime.now().add(const Duration(hours: 4320)),
    );
    if (picked != null) {
      vm.selectDeliveryDate(picked);
      _showTimePicker(context);
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    var vm = context.read<ConfirmOrderViewModel>();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (picked != null) {
      vm.selectDeliveryTime(picked);
    }
  }
}
