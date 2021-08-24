import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'register_viewmodel.dart';

class RegisterScreenMobile extends StatelessWidget {
  const RegisterScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
        create: (_) => RegisterViewModel(
              connectionService: context.read<ConnectionService>(),
              messageService: context.read<MessageService>(),
              tokenService: context.read<TokenService>(),
            ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterViewModel>();
    return SafeArea(
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => vm.toggleLanguage(),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.language,
                              color: FimtoColors.primaryColor,
                            ),
                            const SizedBox(width: 6),
                            Text(S.of(context).changeLanguage,
                                style: Theme.of(context).textTheme.headline5),
                          ],
                        ),
                      )),
                  const SizedBox(height: 90),
                  const Center(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                      color: FimtoColors.primaryColor,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Visibility(
                    child: const Center(child: CircularProgressIndicator()),
                    visible: vm.isLoading,
                  ),
                  Text(
                    S.of(context).phoneNumber,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    textAlign: TextAlign.start,
                    onChanged: (value) => vm.onPhoneNumberChange(value),
                    validator: (value) => vm.validatePhoneNumber(value),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon:const Icon(Icons.phone),
                        hintText: S.of(context).phoneNumber),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    S.of(context).email,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    textAlign: TextAlign.start,
                    onChanged: (value) => vm.onEmailChange(value),
                    validator: (value) => vm.validateEmailAddress(value),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon:const Icon(Icons.email),
                        hintText: S.of(context).email),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    S.of(context).password,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    textAlign: TextAlign.start,
                    onChanged: (value) => vm.onPasswordChange(value),
                    validator: (value) => vm.validatePassword(value),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: S.of(context).password),
                  ),
                  const SizedBox(height: 40),
                  SolidButton(
                    text: S.of(context).register,
                    onTap: () => vm.registerAction(_formKey),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).alreadyHaveAccount,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                      TextButton(
                        onPressed: () {},
                        child: Text(S.of(context).login,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
