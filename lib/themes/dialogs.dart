import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? title;
  final String? message;
  const ErrorDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image(
            //   image: AssetImage(
            //     'assets/images/red_x.png',
            //   ),
            //   fit: BoxFit.fill,
            //   height: 60,
            // ),
            SizedBox(height: 25),
            Text(
              title!,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 10),
            Text(
              message!,
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String? title;
  final String? message;
  const SuccessDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                'assets/images/success.png',
              ),
              fit: BoxFit.fill,
              height: 60,
            ),
            SizedBox(height: 25),
            Text(
              title!,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 10),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
