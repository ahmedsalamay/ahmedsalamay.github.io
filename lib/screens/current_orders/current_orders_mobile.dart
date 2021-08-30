import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/order_status.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/screens/current_orders/current_orders_view.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'current_orders_viewmodel.dart';

class CurrentOrdersScreenMobile extends StatelessWidget {
  const CurrentOrdersScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();
    return ChangeNotifierProvider<CurrentOrdersViewModel>(
        create: (_) => CurrentOrdersViewModel(
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
    var vm = context.watch<CurrentOrdersViewModel>();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar(title: S.of(context).myOrders),
              vm.isLoading
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.4),
                      child: const CircularProgressIndicator(),
                    ))
                  : const _CurrentOrders()
            ],
          )),
    );
  }
}

class _CurrentOrders extends StatelessWidget {
  const _CurrentOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CurrentOrdersViewModel>();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: vm.currentOrders
              .map((order) => _OrderTile(order: order))
              .toList(),
        ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final OrderStatus order;
  const _OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.read<CurrentOrdersViewModel>();
    return Container(
      height: 140,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _DetailsItem(title: S.of(context).name, value: order.name),
                    _DetailsItem(
                        title: S.of(context).total,
                        value: order.total.toString()),
                  ],
                ),
                _DetailsItem(title: S.of(context).phone, value: order.phone),
                _DetailsItem(
                    title: S.of(context).status,
                    value: OrderStatesEn.values[order.status]
                        .toString()
                        .split('.')[1]),
                _PaidDetailsItem(title: S.of(context).paid, paid: order.paid),
              ],
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () => vm.navigateToStatusScreen(order),
            icon: const Icon(Icons.arrow_forward_ios),
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

class _DetailsItem extends StatelessWidget {
  final String title;
  final String value;

  const _DetailsItem({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ],
    );
  }
}

class _PaidDetailsItem extends StatelessWidget {
  final String title;
  final bool paid;

  const _PaidDetailsItem({Key? key, required this.title, required this.paid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        const SizedBox(width: 6),
        Text(
          paid ? S.of(context).yes : S.of(context).no,
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: paid ? Colors.green : Colors.red),
        ),
      ],
    );
  }
}
