import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/repository/local/token_local_repository.dart';
import 'package:fimto_frame/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashViewModel>(
        create: (_) => SplashViewModel(
            tokenLocalRepository: context.read<TokenLocalRepository>(),
            language: context.watch<Language>()),
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
    context.read<SplashViewModel>().initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(color: Colors.deepOrange),
      child: const Center(),
    );
  }
}
