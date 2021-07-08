import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: FimtoColors.iconsColor,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: FimtoColors.primaryColor,
                size: 26,
              ),
              onPressed: () =>
                  Get.until((route) => Get.currentRoute == homeRoute),
            ),
          ),
        ],
      ),
    );
  }
}
