import 'package:fimto_frame/models/city.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'current_orders_viewmodel.dart';

class CurrentOrdersScreenDesktop extends StatelessWidget {
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
    var vm = context.read<AddAddressViewModel>();
    return SafeArea(
      child: Container(
          height: double.infinity,
          child: Column(
            children: [],
          )),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
