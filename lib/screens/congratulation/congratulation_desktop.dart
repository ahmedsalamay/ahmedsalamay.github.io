import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:flutter/material.dart';

class CongratulationsDesktop extends StatefulWidget {
  const CongratulationsDesktop({Key? key}) : super(key: key);

  @override
  _CongratulationsDesktopState createState() => _CongratulationsDesktopState();
}

class _CongratulationsDesktopState extends State<CongratulationsDesktop>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
    return SimpleDialog(
      children: [
        Container(
          height: 600,
          width: 600,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 35),
                      Text(
                        S.of(context).orderConfirmed,
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      ScaleTransition(
                        scale: _animation,
                        child: const Image(
                          height: 230,
                          image:
                              AssetImage('assets/images/congratulations.png'),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        S.of(context).congratulations,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 26),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        S.of(context).successfulPurchase,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        S.of(context).orderNumber,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
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
              SizedBox(
                width: 130,
                child: GradientButton(
                    text: S.of(context).trackYourOrder, onTap: () {}
                    // context.read<CongratulationViewModel>().continueAction
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}
