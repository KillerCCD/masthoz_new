import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/home_screen.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // video controller
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/images/sur.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);

    _playVideo();
  }

  void _playVideo() async {
    // playing video
    _controller.play();

    //add delay till video is complite
    await Future.delayed(const Duration(milliseconds: 5440));

    // navigating to home screen
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fromCssColor('#53424c'),
      body: Stack(
        children: [
          Positioned.fill(
            top: 56,
            child: Opacity(
              opacity: _controller.value.isInitialized ? 1 : 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Text(
                    'Բարի գալուստ',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GHEAGrapalat',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(
                      _controller,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
