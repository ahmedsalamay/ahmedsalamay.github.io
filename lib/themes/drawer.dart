import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 240),
      child: ClipRRect(
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
        child: Drawer(
          child: Container(
            decoration: const BoxDecoration(),
            child: _DrawerItems(),
          ),
        ),
      ),
    );
  }
}

class _DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage('assets/images/BACKGROUND.png'),
          //     fit: BoxFit.cover),
          ),
      child: Column(
        children: [
          const SizedBox(height: 45),
          const Image(
            height: 30,
            color: FimtoColors.primaryColor,
            image: AssetImage(
              'assets/images/logo.png',
            ),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  title: Text(
                    S.of(context).talkToUs,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    S.of(context).addPromoCode,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    S.of(context).faq,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    S.of(context).usePolicy,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ListTile(
                  onTap: () => Get.toNamed(currentOrdersRoute),
                  title: Text(
                    S.of(context).yourOrders,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    S.of(context).fimtoSoft,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    S.of(context).fimtoArt,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const _LanguageTile(),
                const Spacer(),
                ListTile(
                  onTap: () {},
                  title: Text(
                    S.of(context).followUs,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 18),
                  ),
                  subtitle: Row(
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
                ),
                const SizedBox(height: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          MaterialButton(
            onPressed: () => language.changeToEnLanguage(),
            child: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/us.png'),
                  height: 15,
                ),
                const SizedBox(width: 6),
                Text('En',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(width: 25),
          MaterialButton(
            onPressed: () => language.changeToArLanguage(),
            child: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/egypt.png'),
                  height: 15,
                ),
                const SizedBox(width: 6),
                Text('AR',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 16)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
