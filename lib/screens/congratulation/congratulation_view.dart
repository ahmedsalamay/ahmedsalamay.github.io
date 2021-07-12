import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'congratulations_viewmodel.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: CongratulationsMobile(),
        landscape: CongratulationsMobile(),
      ),
      tablet: OrientationLayout(
        portrait: CongratulationsMobile(),
        landscape: CongratulationsMobile(),
      ),
      desktop: OrientationLayout(
        landscape: CongratulationsMobile(),
        portrait: CongratulationsMobile(),
      ),
    );
  }
}

class CongratulationsMobile extends StatelessWidget {
  const CongratulationsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CongratulationViewModel>(
        create: (_) => CongratulationViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(title: S.of(context).congratulations),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 35),
                    Text(
                      S.of(context).orderConfirmed,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    Image(
                      height: 230,
                      image: AssetImage('assets/images/congratulations.png'),
                    ),
                    SizedBox(height: 25),
                    Text(
                      S.of(context).congratulations,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      S.of(context).successfulPurchase,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      S.of(context).orderNumber,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      S.of(context).canTrackYourOrder,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GradientButton(
              text: S.of(context).trackYourOrder,
              onTap: context.read<CongratulationViewModel>().continueAction)
        ],
      ),
    );
  }
}
