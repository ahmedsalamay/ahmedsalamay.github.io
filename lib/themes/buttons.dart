import 'package:flutter/material.dart';
import 'package:fimto_frame/themes/theme.dart';

class SolidButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  final Color background;
  final bool isLoading;
  const SolidButton({
    this.onTap,
    required this.text,
    this.background = FimtoColors.primaryColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: onTap == null ? Theme.of(context).disabledColor : background,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  text!,
                  style: Theme.of(context).textTheme.button,
                ),
        ),
      ),
    );
  }
}

class SolidButtonWithIcon extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  final Color background;
  final bool isLoading;
  final IconData iconData;
  const SolidButtonWithIcon({
    this.onTap,
    required this.text,
    required this.iconData,
    this.background = FimtoColors.primaryColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: onTap == null ? Theme.of(context).disabledColor : background,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        iconData,
                        color: Colors.white,
                      ),
                      Text(
                        text!,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  )),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  const GradientButton({
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(vertical: 6),
        width: MediaQuery.of(context).size.width * 0.75,
        child: Center(
            child: Text(
          text!,
          style: Theme.of(context).textTheme.button,
        )),
        decoration: onTap == null
            ? BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                gradient: FimtoColors.buttonLinearGradient,
                borderRadius: BorderRadius.circular(25),
              ),
      ),
    );
  }
}

class DefaultOutlineBorder extends StatelessWidget {
  final Widget child;
  const DefaultOutlineBorder({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: FimtoColors.primaryColor,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: child,
    );
  }
}
