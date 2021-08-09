import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/themes/footer.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'components/header.dart';

class HomeViewDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _Title(),
                    SizedBox(height: 15),
                    _MoreInfo(),
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

class _Title extends StatefulWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  __TitleState createState() => __TitleState();
}

class __TitleState extends State<_Title> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GestureDetector(
              onTap: () => setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              }),
              child: SizedBox(
                height: 250,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),
          _FramesPrice()
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
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            S.of(context).frameYourMoment,
            style: Theme.of(context).textTheme.headline2,
          ),
          // SizedBox(width: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                fit: BoxFit.fill,
                height: 35,
                image: AssetImage('assets/images/photo-FB.png'),
              ),
              SizedBox(width: 16),
              Image(
                fit: BoxFit.fill,
                height: 35,
                image: AssetImage('assets/images/photo-FB.png'),
              ),
              SizedBox(width: 16),
              Image(
                fit: BoxFit.fill,
                height: 35,
                image: AssetImage('assets/images/photo-FB.png'),
              ),
            ],
          ),
          // SizedBox(width: 16),
          Text(
            S.of(context).getThreeFrames,
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
          ),
          //  SizedBox(height: 10),
          Text(
            S.of(context).youCanExtraFrame,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          Text(
            S.of(context).noNails,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
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
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Get three Frames with 270 LE only',
              textAlign: TextAlign.center, style: _style),
          Text('Get three Frames with 270 LE only',
              textAlign: TextAlign.center, style: _style),
          Text('You can add extra frame with only 74LE',
              textAlign: TextAlign.center, style: _style),
          Text(S.of(context).noNails,
              textAlign: TextAlign.center, style: _style),
        ],
      ),
    );
  }

  final _style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
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
          Row(
            children: [
              Expanded(flex: 1, child: _CustomContainer()),
              Expanded(flex: 1, child: _SocialPosts()),
            ],
          ),
          SizedBox(height: 200),
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
    final TabController? controller = DefaultTabController.of(context);

    return Container(
        height: 300,
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: controller,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      width: 250,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/social_post.png'),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/social_post.png'),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/social_post.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TabPageSelector(
                controller: controller,
                color: Colors.grey[300],
                selectedColor: FimtoColors.primaryColor,
              ),
            ],
          ),
        ));
  }
}
