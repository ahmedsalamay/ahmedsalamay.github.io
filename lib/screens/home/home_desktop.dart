import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/home_page_configuration.dart';
import 'package:fimto_frame/models/social_reviews.dart';
import 'package:fimto_frame/repository/remote/configuration_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'components/header.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:provider/provider.dart';
import 'home_viewmodel.dart';

class HomeViewDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (_) => HomeViewModel(
            connectionService: context.read<ConnectionService>(),
            messageService: context.read<MessageService>(),
            configurationRepository: context.read<ConfigurationRepository>()),
        child: _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _Title(),
                    SizedBox(height: 15),
                    _MoreInfo(),
                    Divider(indent: 20, endIndent: 20),
                    Footer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
        height: 350,
        child: YoutubePlayerIFrame(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: FutureBuilder<HomePageConfiguration>(
                future:
                    context.read<HomeViewModel>().loadHomePageConfiguration(),
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
          ),
          Expanded(flex: 2, child: _FrameYourMoment())
        ],
      ),
    );
  }
}

class _FramesPrices extends StatelessWidget {
  const _FramesPrices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              fit: BoxFit.fill,
              height: 45,
              image: AssetImage('assets/images/photo-FB.png'),
            ),
            SizedBox(width: 20),
            Image(
              fit: BoxFit.fill,
              height: 45,
              image: AssetImage('assets/images/photo-FB.png'),
            ),
            SizedBox(width: 20),
            Image(
              fit: BoxFit.fill,
              height: 45,
              image: AssetImage('assets/images/photo-FB.png'),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          S.of(context).getThreeFrames,
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 24),
        ),
        SizedBox(height: 15),
        Text(
          S.of(context).youCanExtraFrame,
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _FrameYourMoment extends StatelessWidget {
  const _FrameYourMoment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).frameYourMoment,
            style:
                Theme.of(context).textTheme.headline3!.copyWith(fontSize: 40),
          ),
          SizedBox(height: 25),
          Expanded(
            child: Text(
              S.of(context).addAestheticTouch,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 25),
          ElevatedButton(
              onPressed: () => Get.toNamed(selectToWhoRoute),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                child: Text(S.of(context).letsGo),
              )),
          SizedBox(height: 25),
          Row(
            children: [
              Icon(
                Icons.delivery_dining,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                S.of(context).shippingFree,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BulletPoint(S.of(context).noNails),
          _BulletPoint(S.of(context).changLocation),
          _BulletPoint(S.of(context).suitableShape),
          _BulletPoint(S.of(context).perfectSize),
          _BulletPoint(S.of(context).perfectSize),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_forward_ios_outlined, color: Colors.black),
        SizedBox(width: 10),
        Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            )),
      ],
    );
  }
}

class _MoreInfo extends StatelessWidget {
  const _MoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 25),
      decoration: BoxDecoration(
        // color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: _CustomContainer()),
              Expanded(flex: 2, child: _FramesPrices()),
            ],
          ),
          SizedBox(height: 50),
          _SocialPosts(),
          SizedBox(height: 50),
          Text(
            S.of(context).guaranteeOurFrames,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            S.of(context).youCanRetrieve,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
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
        height: 400,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                              width: 350,
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
            }));
  }
}
