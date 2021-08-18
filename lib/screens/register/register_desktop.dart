import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'register_viewmodel.dart';

class RegisterScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
        create: (_) => RegisterViewModel(
              connectionService: context.read<ConnectionService>(),
              messageService: context.read<MessageService>(),
              tokenService: context.read<TokenService>(),
            ),
        child: Scaffold(
          backgroundColor: Color(0xFFf6fafb),
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterViewModel>();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            _Header(),
            SizedBox(height: size.height * 0.1),
            Container(
              height: 450,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
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
                      SizedBox(height: 10),
                      Visibility(
                        child: Center(child: CircularProgressIndicator()),
                        visible: vm.isLoading,
                      ),
                      TextFormField(
                        textAlign: TextAlign.start,
                        onChanged: (value) => vm.onPhoneNumberChange(value),
                        validator: (value) => vm.validatePhoneNumber(value),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: S.of(context).phoneNumber),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        textAlign: TextAlign.start,
                        onChanged: (value) => vm.onEmailChange(value),
                        validator: (value) => vm.validateEmailAddress(value),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: S.of(context).email),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        textAlign: TextAlign.start,
                        onChanged: (value) => vm.onPasswordChange(value),
                        validator: (value) => vm.validatePassword(value),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: S.of(context).password),
                      ),
                      SizedBox(height: 40),
                      SolidButton(
                        text: S.of(context).register,
                        onTap: () => vm.registerAction(_formKey),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).alreadyHaveAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        children: [
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
