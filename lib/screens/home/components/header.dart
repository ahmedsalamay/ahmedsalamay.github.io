import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
          TextButton(
              onPressed: () {},
              child: Text(S.of(context).faq,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 15))),
          SizedBox(width: 25),
          TextButton(
              onPressed: () {},
              child: Text(S.of(context).yourOrders,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 15))),
          SizedBox(width: 25),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(width: 2.0, color: FimtoColors.primaryColor),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 22)),
            onPressed: () => Get.toNamed(selectToWhoRoute),
            child: Text(S.of(context).letsGo),
          )
        ],
      ),
    );
  }
}
