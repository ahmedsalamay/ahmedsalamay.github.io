import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 3,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ]),
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
              icon: Icon(Icons.menu, size: 30, color: Colors.black),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
