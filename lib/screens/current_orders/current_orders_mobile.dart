import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/order_status.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'current_orders_viewmodel.dart';

class CurrentOrdersScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();
    return ChangeNotifierProvider<AddAddressViewModel>(
        create: (_) => AddAddressViewModel(
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
    var vm = context.watch<AddAddressViewModel>();
    return SafeArea(
      child: Container(
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar(title: S.of(context).addAddress),
              vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _CurrentOrders()
            ],
          )),
    );
  }
}

class _CurrentOrders extends StatelessWidget {
  const _CurrentOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddAddressViewModel>();

    return SingleChildScrollView(
      child: Column(
        children:
            vm.currentOrders.map((order) => _OrderTile(order: order)).toList(),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final OrderStatus order;
  const _OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(order.name),
          Text(order.total.toString()),
          Text(order.status.toString()),
        ],
      ),
    );
  }
}
