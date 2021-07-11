import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/repository/local/token_local_repository.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'add_address_viewmodel.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: AddAddressScreenMobile(),
        landscape: AddAddressScreenMobile(),
      ),
      tablet: OrientationLayout(
        portrait: AddAddressScreenMobile(),
        landscape: AddAddressScreenMobile(),
      ),
      desktop: OrientationLayout(
        landscape: AddAddressScreenMobile(),
        portrait: AddAddressScreenMobile(),
      ),
    );
  }
}

class AddAddressScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddAddressViewModel>(
        create: (_) => AddAddressViewModel(),
        child: Scaffold(
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
    final height = MediaQuery.of(context).size.height;
    return Container(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: _AddressForm(),
                ),
              ),
              GradientButton(
                text: S.of(context).confirmAddress,
                onTap: () {},
              )
            ],
          ),
        ));
  }
}

class _AddressForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
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
    );
  }
}
