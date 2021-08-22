import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/home_page_configuration.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/social_reviews.dart';
import 'package:fimto_frame/repository/remote/configuration_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();
    return ChangeNotifierProvider<HomeViewModel>(
        create: (_) => HomeViewModel(
            connectionService: context.read<ConnectionService>(),
            messageService: context.read<MessageService>(),
            order: context.read<Order>(),
            configurationRepository: context.read<ConfigurationRepository>()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              endDrawer: language.currentLocale.languageCode == 'en'
                  ? CustomDrawer()
                  : null,
              drawer: language.currentLocale.languageCode == 'ar'
                  ? CustomDrawer()
                  : null,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppBar(title: ''),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _Title(),
                          _FramesPrice(),
                          SizedBox(height: 15),
                          _MoreInfo(),
                        ],
                      ),
                    ),
                  ),
                  GradientButton(
                      text: S.of(context).letsGo,
                      onTap: () => Get.toNamed(selectToWhoRoute))
                ],
              ),
            ),
          ),
        ));
  }
}

class _Video extends StatefulWidget {
  final String videoId;
  const _Video({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<_Video> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      params: const YoutubePlayerParams(
          showControls: false,
          showFullscreenButton: true,
          desktopMode: false,
          privacyEnhanced: true,
          useHybridComposition: true,
          mute: true,
          autoPlay: true,
          loop: true,
          showVideoAnnotations: false),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {};
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
          height: 250,
          child: YoutubePlayerIFrame(
            controller: _controller,
            aspectRatio: 16 / 9,
          )),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<HomeViewModel>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        // color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image(
            fit: BoxFit.contain,
            height: 50,
            color: FimtoColors.primaryColor,
            image: AssetImage('assets/images/logo.png'),
          ),
          SizedBox(height: 25),
          FutureBuilder<HomePageConfiguration>(
              future: vm.homePageConfiguration,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _Video(videoId: snapshot.data!.videoLink);
                } else if (snapshot.hasError) {
                  return Text('Error');
                }
                return PlayStoreShimmer(
                  hasBottomFirstLine: false,
                );
              }),
          SizedBox(height: 25),
          Text(
            S.of(context).frameYourMoment,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }
}

class _FramesPrice extends StatelessWidget {
  const _FramesPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.fill,
                height: 35,
                image: AssetImage('assets/images/photo-FB.png'),
              ),
              SizedBox(width: 8),
              Image(
                fit: BoxFit.fill,
                height: 35,
                image: AssetImage('assets/images/photo-FB.png'),
              ),
              SizedBox(width: 8),
              Image(
                fit: BoxFit.fill,
                height: 35,
                image: AssetImage('assets/images/photo-FB.png'),
              ),
            ],
          ),
          SizedBox(width: 16),
          Text(
            S.of(context).getThreeFrames,
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            S.of(context).youCanExtraFrame,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _CustomContainer extends StatelessWidget {
  final String text;

  const _CustomContainer({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      width: MediaQuery.of(context).size.width * 0.83,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
    );
  }
}

class _MoreInfo extends StatelessWidget {
  const _MoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          _CustomContainer(text: S.of(context).noNails),
          _CustomContainer(text: S.of(context).changLocation),
          _CustomContainer(text: S.of(context).shippingFree),
          _CustomContainer(text: S.of(context).suitableShape),
          SizedBox(height: 15),
          _SocialPosts(),
          SizedBox(height: 15),
          _CustomContainer(text: S.of(context).perfectSize),
          _CustomContainer(text: S.of(context).youCanChangeThePhoto),
          _CustomContainer(text: S.of(context).addAestheticTouch),
          SizedBox(height: 25),
          Text(
            S.of(context).guaranteeOurFrames,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            S.of(context).youCanRetrieve,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialPosts extends StatelessWidget {
  const _SocialPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 300,
      child: FutureBuilder<List<SocialReviews>>(
          future: context.read<HomeViewModel>().loadHomeSocialReviews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!
                      .map((e) => Container(
                            height: 400,
                            width: 300,
                            padding: EdgeInsets.all(15),
                            child: Placeholder(
                              strokeWidth: 3,
                            )
                            /* Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/social_post.png'),
                    )*/
                            ,
                          ))
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            }
            return PlayStoreShimmer(
              hasBottomFirstLine: true,
            );
          }),
    );
  }
}
