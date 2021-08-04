import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                text: 'Let\'s Go', onTap: () => Get.toNamed(selectToWhoRoute))
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
          SizedBox(height: 25),
          Text(
            'FRAME YOUR MOMENTS',
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
            'Get three Frames with 270 LE only',
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            'You can add extra frame with only 74LE',
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
          _CustomContainer(text: 'IT DOESN\'T NEED A NAILS'),
          _CustomContainer(
              text: 'CHANGE THE LOCATION WITHOUT LEAVING ANY TRACE'),
          _CustomContainer(text: 'SHIPPING IS ALWAYS FREE'),
          _CustomContainer(
              text:
                  'WE GIVE YOU THE MOST SUITABLE SHAPE FOR THE FRAME ON YOUR WALL'),
          SizedBox(height: 15),
          _SocialPosts(),
          SizedBox(height: 15),
          _CustomContainer(text: 'PERFECT FRAME SIZE 21X21'),
          _CustomContainer(
              text: 'YOU CAN CHANGE THE PHOTO INSIDE THE FRAME ANY TIME'),
          _CustomContainer(
              text: 'WE WILL ADD AN AESTHETIC TOUCH TO YOUR PHOTOS'),
          SizedBox(height: 25),
          Text(
            'WE GUARANTEE OUR FRAME!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'YOU CAN RETRIEVE IT IF IT ISN\'T IN THE REQUIRED FORM',
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
        width: MediaQuery.of(context).size.width * 0.75,
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
