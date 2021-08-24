import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.27,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 6),
                TextButton(
                  onPressed: () => language.currentLocale.languageCode == 'en'
                      ? language.changeToArLanguage()
                      : language.changeToEnLanguage(),
                  child: Text(language.currentLocale.languageCode == 'ar'
                      ? 'English'
                      : 'العربية'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).usePolicy,
                        style: textTheme,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).faq,
                        style: textTheme,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).yourOrders,
                        style: textTheme,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).talkToUs,
                        style: textTheme,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [_FollowUs(), _PaymentMethod()],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FollowUs extends StatelessWidget {
  const _FollowUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
              S.of(context).followUs,
              style: textTheme,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Image(
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/INSTAGRAM.png"),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Image(
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/twitter.png"),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Image(
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/facebookGrey.png"),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Image(
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/googleGrey.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  const _PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
              S.of(context).paymentMethod,
              style: textTheme,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Image(
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/orange.png"),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Image(
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/vodafone.png"),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Image(
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/etisalat.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const textTheme = TextStyle(
  color: Color(0xFFa2a5af),
  fontWeight: FontWeight.w800,
  fontSize: 18,
);
