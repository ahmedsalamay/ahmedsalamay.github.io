import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/responsive/responsive_layout.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: OnBordingMobileView(),
        landscape: OnBordingMobileView(),
      ),
      tablet: OrientationLayout(
        portrait: OnBordingMobileView(),
        landscape: OnBordingMobileView(),
      ),
      desktop: OrientationLayout(
        landscape: OnBordingMobileView(),
        portrait: OnBordingMobileView(),
      ),
    );
  }
}

class OnBordingMobileView extends StatelessWidget {
  getOnBordingPages(BuildContext context) {
    final List<OnBording> onBordingPages = <OnBording>[
      OnBording(Color(0xFF634F95), 'onboard1.png', S.of(context).noNails,
          Color(0xfff9a825), S.of(context).framesStickWall),
      OnBording(Color(0xFF878A94), 'onboard2.png', S.of(context).shapeFrame,
          Color(0xff00bcd4), S.of(context).suitableShape),
      OnBording(Color(0xFFF82020), 'onboard3.png', S.of(context).shippingFree,
          Colors.deepOrange, S.of(context).egyptwideShipping),
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
  final Color titleColor;
  final String description;
  const OnBording(this.backgroundColor, this.imagePath, this.title,
      this.titleColor, this.description);
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
          physics: AlwaysScrollableScrollPhysics(),
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
                      SizedBox(
                        height: 42,
                      ),
                      Text(page.title,
                          style: Theme.of(context).textTheme.headline1),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          page.description,
                          style: Theme.of(context).textTheme.bodyText1,
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
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  onPressed: () => Get.toNamed(homeRoute),
                  child: Text(
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
