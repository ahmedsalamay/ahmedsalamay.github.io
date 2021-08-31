import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/repository/remote/preference.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: const OnBordingMobileView(),
        landscape: const OnBordingMobileView(),
      ),
      tablet: OrientationLayout(
        portrait: const OnBordingMobileView(),
        landscape: const OnBordingMobileView(),
      ),
      desktop: OrientationLayout(
        landscape: const OnBordingMobileView(),
        portrait: const OnBordingMobileView(),
      ),
    );
  }
}

class OnBordingMobileView extends StatelessWidget {
  const OnBordingMobileView({Key? key}) : super(key: key);

  getOnBordingPages(BuildContext context) {
    final List<OnBording> onBordingPages = <OnBording>[
      OnBording(const Color(0xFF331f28), 'onboard1.png', S.of(context).noNails,
          S.of(context).framesStickWall),
      OnBording(const Color(0xFFa5a5a5), 'onboard2.png',
          S.of(context).shapeFrame, S.of(context).suitableShape),
      OnBording(const Color(0xFFe63716), 'onboard3.png',
          S.of(context).shippingFree, S.of(context).egyptwideShipping),
    ];
    return onBordingPages;
  }

  @override
  Widget build(BuildContext context) {
    final onBordingPages = getOnBordingPages(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: onBordingPages.length,
        child: _PageSelector(onbordingPages: onBordingPages),
      ),
    );
  }
}

class OnBording {
  final Color backgroundColor;
  final String imagePath;
  final String title;
  final String description;
  const OnBording(
      this.backgroundColor, this.imagePath, this.title, this.description);
}

class _PageSelector extends StatelessWidget {
  const _PageSelector({required this.onbordingPages});

  final List<OnBording> onbordingPages;

  @override
  Widget build(BuildContext context) {
    final TabController? controller = DefaultTabController.of(context);
    return Stack(
      children: <Widget>[
        TabBarView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: onbordingPages
              .map(
                (page) => Container(
                  decoration: BoxDecoration(
                    color: page.backgroundColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/' + page.imagePath),
                      ),
                      const SizedBox(
                        height: 42,
                      ),
                      Text(page.title,
                          style: Theme.of(context).textTheme.headline1),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          page.description,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TabPageSelector(
                        controller: controller,
                        color: Colors.transparent,
                        selectedColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  onPressed: () async {
                    final preferences = await Preferences.getInstance();
                    final isUserLoggedIn = preferences.getIsLogged();
                    preferences.setIsFirstLaunch(false);
                    Get.toNamed(isUserLoggedIn ? homeRoute : loginRoute);
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
