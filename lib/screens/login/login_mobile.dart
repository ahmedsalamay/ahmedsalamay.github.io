import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:get/get.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'login_viewmodel.dart';

class LoginScreenMobile extends StatelessWidget {
  final bool isComingFromGuest;

  const LoginScreenMobile({Key? key, required this.isComingFromGuest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (_) => LoginViewModel(
            connectionService: context.read<ConnectionService>(),
            messageService: context.read<MessageService>(),
            language: context.read<Language>(),
            tokenService: context.read<TokenService>(),
            isComingFromGuest: isComingFromGuest),
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
    final vm = context.watch<LoginViewModel>();
    final height = MediaQuery.of(context).size.height;
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontSize: 16)),
                          ],
                        ),
                      )),
                  SizedBox(height: height * 0.1),
                  Center(
                    child: Image(
                      image: const AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                      color: FimtoColors.primaryColor,
                      height: height * 0.09,
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  Visibility(
                    child: const Center(child: CircularProgressIndicator()),
                    visible: vm.isLoading,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    textAlign: TextAlign.start,
                    onChanged: (value) => vm.onPhoneNumberChange(value),
                    validator: (value) => vm.validatePhoneNumber(value),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        hintText: S.of(context).phoneNumber),
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
                  const SizedBox(height: 30),
                  SolidButton(
                    text: S.of(context).login,
                    onTap: () => vm.logInAction(_formKey),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => vm.continueAsGuestAction(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(S.of(context).continueAsGuest),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(S.of(context).forgotPassword,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).donnotHaveAccount,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                      TextButton(
                        onPressed: () => Get.toNamed(registerRoute),
                        child: Text(S.of(context).register,
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
