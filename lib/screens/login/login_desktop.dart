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

class LoginScreenDesktop extends StatelessWidget {
  final bool isComingFromGuest;

  const LoginScreenDesktop({Key? key, required this.isComingFromGuest})
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
          backgroundColor: const Color(0xFFf6fafb),
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const _Header(),
            SizedBox(height: size.height * 0.1),
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Spacer(),
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
                        onFieldSubmitted: (_) => vm.logInAction(_formKey),
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: S.of(context).password),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: SizedBox(
                          width: 140,
                          child: SolidButton(
                            text: S.of(context).login,
                            onTap: () => vm.logInAction(_formKey),
                          ),
                        ),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).donnotHaveAccount,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
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
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        children: const [
          Image(
            fit: BoxFit.contain,
            height: 30,
            color: FimtoColors.primaryColor,
            image: AssetImage('assets/images/logo.png'),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
