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
              icon: Image(
                height: 20,
                width: 20,
                fit: BoxFit.fill,
                image: AssetImage('assets/images/down-arrow.png'),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Image(
                height: 20,
                width: 20,
                fit: BoxFit.fill,
                image: AssetImage('assets/images/list-text.png'),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
