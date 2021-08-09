import 'package:get/get.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'add_address_viewmodel.dart';

class AddAddressScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddAddressViewModel>(
        create: (_) => AddAddressViewModel(),
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
    context.read<AddAddressViewModel>().initAsync();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddAddressViewModel>();
    return SafeArea(
      child: Container(
          height: double.infinity,
          child: Column(
            children: [
              CustomAppBar(title: S.of(context).addAddress),
              _Stepper(),
              Expanded(
                child: SingleChildScrollView(
                  child: _AddressForm(),
                ),
              ),
              GradientButton(
                text: S.of(context).confirmAddress,
                onTap: () => Get.toNamed(addPaymentMethodRoute),
              )
            ],
          )),
    );
  }
}

class _AddressForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              S.of(context).shipTo,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 15),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onUserNameChange(value),
              // validator: (value) => vm.validateUserName(value),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(hintText: S.of(context).nameHint),
            ),
            SizedBox(height: 12),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onPasswordChange(value),
              // validator: (value) => vm.validatePassword(value),
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(hintText: S.of(context).phoneHint),
            ),
            SizedBox(height: 12),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onPasswordChange(value),
              // validator: (value) => vm.validatePassword(value),
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Cairo'),
            ),
            SizedBox(height: 12),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onPasswordChange(value),
              // validator: (value) => vm.validatePassword(value),
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Nasser City'),
            ),
            SizedBox(height: 12),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onPasswordChange(value),
              // validator: (value) => vm.validatePassword(value),
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(hintText: S.of(context).addressHint),
            ),
            SizedBox(height: 12),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onPasswordChange(value),
              // validator: (value) => vm.validatePassword(value),
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration:
                  InputDecoration(hintText: S.of(context).buildingNumberHint),
            ),
            SizedBox(height: 12),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onPasswordChange(value),
              // validator: (value) => vm.validatePassword(value),
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(hintText: S.of(context).floorHint),
            ),
            SizedBox(height: 12),
            TextFormField(
              textAlign: TextAlign.start,
              // onChanged: (value) => vm.onPasswordChange(value),
              // validator: (value) => vm.validatePassword(value),
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(hintText: S.of(context).mailHint),
            ),
          ],
        ),
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
                    '2',
                    style: TextStyle(
                        color: FimtoColors.dividerColor,
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
          )
        ],
      ),
    );
  }
}
