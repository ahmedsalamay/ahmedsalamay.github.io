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
import 'add_address_viewmodel.dart';

class AddAddressScreenDesktop extends StatelessWidget {
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
          width: double.infinity,
          child: Row(
            children: [
              _Stepper(),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _AddressForm(),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 180,
                      child: GradientButton(
                        text: S.of(context).confirmAddress,
                        onTap: () => vm.confirmAddressAction(),
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

class _AddressForm extends StatefulWidget {
  @override
  __AddressFormState createState() => __AddressFormState();
}

class __AddressFormState extends State<_AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<AddAddressViewModel>().initAsync();
  }

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddAddressViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                S.of(context).shipTo,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      onChanged: (value) => vm.onUserNameChange(value),
                      // validator: (value) => vm.validateUserName(value),
                      textInputAction: TextInputAction.next,
                      decoration:
                          InputDecoration(hintText: S.of(context).nameHint),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      onChanged: (value) => vm.onPhoneNumberChange(value),
                      // validator: (value) => vm.validatePassword(value),
                      textInputAction: TextInputAction.done,
                      decoration:
                          InputDecoration(hintText: S.of(context).phoneHint),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _CityDropDown()),
                  SizedBox(width: 12),
                  Expanded(child: _RegionDropDown())
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      onChanged: (value) => vm.onBuildNoChange(value),
                      // validator: (value) => vm.validatePassword(value),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: S.of(context).buildingNumberHint),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      onChanged: (value) => vm.onFloorChange(value),
                      // validator: (value) => vm.validatePassword(value),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration:
                          InputDecoration(hintText: S.of(context).floorHint),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextFormField(
                textAlign: TextAlign.start,
                onChanged: (value) => vm.onAddressChange(value),
                // validator: (value) => vm.validatePassword(value),
                textInputAction: TextInputAction.done,
                decoration:
                    InputDecoration(hintText: S.of(context).addressHint),
              ),
              SizedBox(height: 12),
              TextFormField(
                textAlign: TextAlign.start,
                onChanged: (value) => vm.onEmailChange(value),
                // validator: (value) => vm.validatePassword(value),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: S.of(context).mailHint),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegionDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddAddressViewModel>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Color(0xffe4e4e4), borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<Region>(
        isExpanded: true,
        value: vm.selectedRegion,
        hint: Text(
          '',
          textAlign: TextAlign.center,
        ),
        iconSize: 24,
        elevation: 16,
        icon: vm.isLoading
            ? CircularProgressIndicator(strokeWidth: 2)
            : Icon(Icons.arrow_drop_down, size: 36),
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: (Region? region) =>
            context.read<AddAddressViewModel>().selectRegion(region!),
        items: vm.regions?.map((Region region) {
          return DropdownMenuItem<Region>(
            value: region,
            child: Text(region.name,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16)),
          );
        }).toList(),
      ),
    );
  }
}

class _CityDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<AddAddressViewModel>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Color(0xffe4e4e4), borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<City>(
        isExpanded: true,
        value: vm.selectedCity,
        hint: Text(
          '',
          textAlign: TextAlign.center,
        ),
        iconSize: 24,
        elevation: 16,
        icon: vm.isLoading
            ? CircularProgressIndicator(strokeWidth: 2)
            : Icon(Icons.arrow_drop_down, size: 36),
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: (City? city) =>
            context.read<AddAddressViewModel>().selectCity(city!),
        items: vm.cities?.map((City city) {
          return DropdownMenuItem<City>(
            value: city,
            child: Text(city.name,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16)),
          );
        }).toList(),
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
                SizedBox(height: 12),
                Expanded(
                    child: VerticalDivider(
                  thickness: 4,
                )),
                SizedBox(height: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: FimtoColors.dividerColor, width: 3)),
                  child: Center(
                      child: Text(
                    '2',
                    style: TextStyle(
                        color: FimtoColors.dividerColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  )),
                ),
                SizedBox(height: 12),
                Expanded(child: VerticalDivider(thickness: 4)),
                SizedBox(height: 12),
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
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  S.of(context).payment,
                  style: TextStyle(
                      color: FimtoColors.dividerColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  S.of(context).confirmation,
                  style: TextStyle(
                      color: FimtoColors.dividerColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
