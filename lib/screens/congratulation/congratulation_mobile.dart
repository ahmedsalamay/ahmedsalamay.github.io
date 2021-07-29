import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'congratulations_viewmodel.dart';

class CongratulationsMobile extends StatelessWidget {
  const CongratulationsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CongratulationViewModel>(
        create: (_) => CongratulationViewModel(),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: CustomDrawer(),
          body: _Body(),
        ));
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceInOut,
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                    ScaleTransition(
                      scale: _animation,
                      child: Image(
                        height: 230,
                        image: AssetImage('assets/images/congratulations.png'),
                      ),
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
