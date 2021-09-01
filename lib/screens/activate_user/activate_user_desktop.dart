import 'package:fimto_frame/repository/remote/token_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'activate_user_viewmodel.dart';

class ActivateUserScreenDesktop extends StatelessWidget {
  final String phoneNumber;

  const ActivateUserScreenDesktop({Key? key, required this.phoneNumber})
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
          backgroundColor: const Color(0xFFf6fafb),
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
          child: SingleChildScrollView(
            child: OTPTextField(
              length: 5,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 80,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
          ),
        ),
      ),
    );
  }
}
