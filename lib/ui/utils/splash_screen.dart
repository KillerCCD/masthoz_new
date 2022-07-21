import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/size_config.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/login_screen/login_screen.dart';
import 'package:rive/rive.dart';
import 'package:cross_connectivity/cross_connectivity.dart';

import '../widgets/main_page/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  // late RiveAnimationController _controller;
  bool isActive = false;
  @override
  void initState() {
    super.initState();
    // _controller = OneShotAnimation('Mashtoz', autoplay: false);
    play();
  }

  void play() async {
    await Future.delayed(Duration(milliseconds: 4000));
    if (isActive) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginScreen()));
    }
    // ConnectivityStatus.none == true
    //     ? Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (_) => LoginScreen()))
    //     : Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(83, 66, 77, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Բարի գալուստ',
                style: TextStyle(
                    fontFamily: 'GHEAGrapalat',
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 500,
              width: SizeConfig.screenWidth,
              child: RiveAnimation.asset(
                'assets/images/mashtoz3.riv',
                alignment: Alignment.center,
                // controllers: [_controller],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20.0),
            child: Align(
              alignment: Alignment.topRight,
              child:
                  ConnectivityBuilder(builder: (context, isConnected, status) {
                if (isConnected == true) {
                  isActive = isConnected!;
                } else {
                  isActive = false;
                }
                return Icon(
                  isConnected == true
                      ? Icons.signal_wifi_4_bar
                      : Icons.signal_wifi_off,
                  color: isConnected == true ? Colors.green : Colors.red,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:from_css_color/from_css_color.dart';
// import 'package:mashtoz_flutter/ui/widgets/main_page/home_screen.dart';
// import 'package:video_player/video_player.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   // video controller
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = VideoPlayerController.asset(
//       'assets/images/mashtoz.mp4',
//     )
//       ..initialize().then((_) {
//         setState(() {});
//       })
//       ..setVolume(0.0);

//     _playVideo();
//   }

//   void _playVideo() async {
//     // playing video
//     _controller.play();

//     //add delay till video is complite
//     await Future.delayed(const Duration(milliseconds: 3640));

//     // navigating to home screen
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: fromCssColor('#53424c'),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(
//                   _controller,
//                 ),
//               )
//             : Container(),
//       ),
//     );
//   }
// }
