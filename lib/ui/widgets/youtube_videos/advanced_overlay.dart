// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class AdvancedOverlayWidget extends StatelessWidget {
//   final YoutubePlayerController controller;
//   final VoidCallback? onClickedFullScreen;

//   static const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2, 3, 5, 10];

//   const AdvancedOverlayWidget({
//     Key? key,
//     required this.controller,
//     this.onClickedFullScreen,
//   }) : super(key: key);

//   String getPosition() {
//     final duration = Duration(
//         milliseconds: controller.value.position.inMilliseconds.round());

//     return [duration.inMinutes, duration.inSeconds]
//         .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
//         .join(':');
//   }

//   @override
//   Widget build(BuildContext context) => Stack(
//         children: <Widget>[
       
//         ],
//       );
// }
