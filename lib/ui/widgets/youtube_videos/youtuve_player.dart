// import 'dart:developer';YoutubePlayerController

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mashtoz_flutter/config/palette.dart';
// import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:video_player/video_player.dart';
// import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';

// import '../helper_widgets/save_show_dialog.dart';

// class YoutubePlayers extends StatefulWidget {
//   final Lessons? lessons;
//   final ByCharacters? dataCharacters;
//   final bool? isShow;
//   final String? url;
//   const YoutubePlayers({
//     Key? key,
//     this.lessons,
//     this.dataCharacters,
//     this.isShow,
//     this.url,
//   }) : super(key: key);

//   @override
//   _YoutubePlayersState createState() => _YoutubePlayersState(
//       lessons: lessons,
//       dataCharacters: dataCharacters,
//       isShow: isShow,
//       url: url);
// }

// class _YoutubePlayersState extends State<YoutubePlayers> {
//   late YoutubePlayerController _controller;
//   late TextEditingController _idController;
//   final bool? isShow;
//   final Lessons? lessons;
//   final String? url;
//   final ByCharacters? dataCharacters;
//   _YoutubePlayersState(
//       {this.lessons, this.dataCharacters, this.isShow, this.url});
//   final List<String> _ids = [
//     'bcO1qrGO9yQ',
//   ];

//   bool _isPlayerReady = false;
//   late TextEditingController _seekToController;
//   late YoutubeMetaData _videoMetaData;
//   late var videoIdd;

//   @override
//   void deactivate() {
//     _controller.pause();
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _idController.dispose();
//     _seekToController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(isShow == true
//           ? 'PB8yF5ZnDYU'
//           : dataCharacters?.link ?? url ?? _ids.first)!,
//       //initialVideoId: _ids.first,
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//         loop: true,
//         // hideThumbnail: true,
//         forceHD: false,
//         enableCaption: false,
//       ),
//     )..addListener(listener);
//     _idController = TextEditingController();
//     _seekToController = TextEditingController();
//     _videoMetaData = const YoutubeMetaData();

//     videoIdd = YoutubePlayer.convertUrlToId("${dataCharacters?.link}");
//   }

//   void listener() {
//     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//       setState(() {
//         _videoMetaData = _controller.metadata;
//       });
//     }
//   }

//   Widget get _space => const SizedBox(height: 20);

//   @override
//   Widget build(BuildContext context) {
//     final oritation = MediaQuery.of(context).orientation;
//     return YoutubePlayerBuilder(
//         player: YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: Palette.main,
//             topActions: <Widget>[
//               const SizedBox(width: 8.0),
//               Expanded(
//                 child: Text(
//                   _controller.metadata.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18.0,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ),
//             ],
//             onReady: () {
//               _isPlayerReady = true;
//             }),
//         builder: (context, player) {
//           return oritation != Orientation.landscape
//               ? isShow == false && oritation != Orientation.landscape ||
//                       isShow == true && oritation != Orientation.landscape
//                   ? Container(
//                       color: Palette.textLineOrBackGroundColor,
//                       child: Column(
//                         children: [
//                           isShow == true
//                               ? Container(
//                                   color: Palette.textLineOrBackGroundColor,
//                                   padding: oritation == Orientation.landscape
//                                       ? EdgeInsets.only(left: 0.0, right: 0.0)
//                                       : EdgeInsets.only(
//                                           left: 20.0, right: 20.0),
//                                   height: isShow == true ? 300 : 600,
//                                   width: oritation == Orientation.landscape
//                                       ? MediaQuery.of(context).size.width
//                                       : 400,
//                                   child: ListView(
//                                     physics: AlwaysScrollableScrollPhysics(),
//                                     scrollDirection: Axis.vertical,
//                                     children: [
//                                       player,
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.stretch,
//                                         children: [
//                                           _space,
//                                           SizedBox(
//                                             width: 270,
//                                             child: Text(
//                                               isShow == true
//                                                   ? '{lessons?.title} '
//                                                   : '{dataCharacters?.summary}',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 12.0,
//                                                 fontFamily: 'GHEAGrapalat',
//                                                 letterSpacing: 1,
//                                                 color: Color.fromRGBO(
//                                                     84, 112, 126, 1),
//                                               ),
//                                               textAlign: TextAlign.justify,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : SizedBox(
//                                   height: 0.01,
//                                 ),

//                           isShow == true && oritation != Orientation.landscape
//                               ? Divider(
//                                   color: Color.fromRGBO(226, 224, 224, 1),
//                                   height: 15.0,
//                                   thickness: 1,
//                                 )
//                               : Container(
//                                   height: 0.01,
//                                 ),
//                           // isShow == true
//                           //     ? Container(
//                           //         padding: EdgeInsets.only(left: 20.0, right: 20.0),
//                           //         color: Palette.textLineOrBackGroundColor,
//                           //         width: double.infinity,
//                           //         height: 49,
//                           //         child: Row(
//                           //           children: [
//                           //             InkWell(
//                           //               onTap: () {
//                           //                 print('kisvel');
//                           //               },
//                           //               child: Row(
//                           //                 children: [
//                           //                   //  const SizedBox(width: 16),
//                           //                   SvgPicture.asset(
//                           //                       'assets/images/այքըններ.svg'),
//                           //                   const SizedBox(width: 6),
//                           //                   const Text('Կիսվել')
//                           //                 ],
//                           //               ),
//                           //             ),
//                           //             Spacer(),
//                           //             InkWell(
//                           //               onTap: () {
//                           //                 print('share anel paterin');
//                           //                 // _showMyDialog();
//                           //                 showDialog(
//                           //                     context: context,
//                           //                     barrierDismissible: false,
//                           //                     builder: (
//                           //                       context,
//                           //                     ) =>
//                           //                         SaveShowDialog());
//                           //               },
//                           //               child: Row(
//                           //                 children: [
//                           //                   SvgPicture.asset(
//                           //                       'assets/images/վելացնել1.svg'),
//                           //                   const SizedBox(width: 6),
//                           //                   const Text('Պահել'),
//                           //                   //const SizedBox(width: 16),
//                           //                 ],
//                           //               ),
//                           //             ),
//                           //           ],
//                           //         ))
//                           //     : Container(
//                           //         height: 0.01,
//                           //       ),
//                         ],
//                       ),
//                     )
//                   : Container(
//                       child: Column(
//                         children: [
//                           SingleChildScrollView(
//                             child: player,
//                           )
//                         ],
//                       ),
//                     )
//               : player;
//         });
//   }

//   // Future<void> _showMyDialog() async {
//   //   return showDialog<void>(
//   //     context: context,
//   //     barrierDismissible: false, // user must tap button!
//   //     builder: (BuildContext context) {},
//   //   );
//   // }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/advanced_overlay.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:wakelock/wakelock.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domens/models/book_data/data.dart';

class YoutubePlayers extends StatefulWidget {
  final Lessons? lessons;
  final Data? dataCharacters;
  final bool? isShow;
  final String? url;
  const YoutubePlayers({
    Key? key,
    this.lessons,
    this.dataCharacters,
    this.isShow,
    this.url,
  }) : super(key: key);

  @override
  _YoutubePlayersState createState() => _YoutubePlayersState(
      lessons: lessons,
      dataCharacters: dataCharacters,
      isShow: isShow,
      url: url);
}

class _YoutubePlayersState extends State<YoutubePlayers> {
  final bool? isShow;
  final Lessons? lessons;
  final String? url;
  final Data? dataCharacters;
  _YoutubePlayersState(
      {this.lessons, this.dataCharacters, this.isShow, this.url});
  late YoutubePlayerController _controller;
  // late TextEditingController _idController;
  bool _isPlayerReady = false;
  // late TextEditingController _seekToController;s
  late YoutubeMetaData _videoMetaData;
  // late var videoIdd;
  @override
  void initState() {
    super.initState();

    // controller = VideoPlayerController.network(lessons!.link!)
    //   ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((_) => controller.play());
    final List<String> _ids = [
      '7dsfGGVCqMI',
    ];

    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(isShow == true
          ? 'PB8yF5ZnDYU'
          : dataCharacters?.link ?? url ?? _ids.first)!,
      //initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
        // hideThumbnail: true,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();

    //   videoIdd = YoutubePlayer.convertUrlToId("${dataCharacters?.link}");
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: VideoPlayerBothWidget(
          controller: _controller,
          metaData: _videoMetaData,
        ),
      );
}

class VideoPlayerBothWidget extends StatefulWidget {
  final YoutubePlayerController controller;
  final YoutubeMetaData metaData;
  const VideoPlayerBothWidget({
    Key? key,
    required this.controller,
    required this.metaData,
  }) : super(key: key);

  @override
  _VideoPlayerBothWidgetState createState() => _VideoPlayerBothWidgetState();
}

class _VideoPlayerBothWidgetState extends State<VideoPlayerBothWidget> {
  Orientation? target;

  @override
  void initState() {
    super.initState();

    NativeDeviceOrientationCommunicator()
        .onOrientationChanged(useSensor: true)
        .listen((event) {
      final isPortrait = event == NativeDeviceOrientation.portraitUp;
      final isLandscape = event == NativeDeviceOrientation.landscapeLeft ||
          event == NativeDeviceOrientation.landscapeRight;
      final isTargetPortrait = target == Orientation.portrait;
      final isTargetLandscape = target == Orientation.landscape;

      if (isPortrait && isTargetPortrait || isLandscape && isTargetLandscape) {
        target = null;
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  @override
  Widget build(BuildContext context) => widget.controller != null
      ? Container(
          color: Colors.black.withOpacity(0.9),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          child: buildVideo())
      : Center(child: CircularProgressIndicator());

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          setOrientation(isPortrait);

          return Stack(
            fit: isPortrait ? StackFit.passthrough : StackFit.expand,
            children: <Widget>[
              isPortrait
                  ? Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: buildVideoPlayer()),
                    )
                  : buildVideoPlayer(),
            ],
          );
        },
      );

  Widget buildVideoPlayer() {
    final video = YoutubePlayer(
      controller: widget.controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Palette.main,
      topActions: <Widget>[
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            widget.metaData.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );

    return buildFullScreen(child: video);
  }

  Widget buildFullScreen({
    @required Widget? child,
  }) {
    final width = 300.0;
    final height = 200.0;

    return Expanded(
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
