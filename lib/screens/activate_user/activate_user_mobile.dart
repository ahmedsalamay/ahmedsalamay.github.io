import 'package:fimto_frame/repository/remote/token_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/material.dart';

import 'activate_user_viewmodel.dart';

class ActivateUserScreenMobile extends StatelessWidget {
  final String phoneNumber;

  const ActivateUserScreenMobile({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivateUserViewModel>(
        create: (_) => ActivateUserViewModel(
              connectionService: context.read<ConnectionService>(),
              messageService: context.read<MessageService>(),
              tokenRepository: context.read<TokenRepository>(),
              phoneNumber: phoneNumber,
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
    final vm = context.watch<ActivateUserViewModel>();
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).otpVerification,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 22),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).enterTheOtp,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      vm.phoneNumber,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 60,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    vm.onCodeChange(pin);
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).didntReceiveOtp,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    TextButton(
                      onPressed: () => vm.resendActivationCode(),
                      child: Text(S.of(context).resendOTP,
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                Visibility(
                    visible: vm.isLoading,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )),
                SolidButton(
                  text: S.of(context).login,
                  onTap: () => vm.activateAction(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
