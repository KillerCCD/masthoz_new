import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';

class YoutubePlayers extends StatefulWidget {
  final Lessons? lessons;
  final ByCharacters? dataCharacters;
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
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  final bool? isShow;
  final Lessons? lessons;
  final String? url;
  final ByCharacters? dataCharacters;
  _YoutubePlayersState(
      {this.lessons, this.dataCharacters, this.isShow, this.url});
  final List<String> _ids = [
    'uKZ8ZyUHpyQ',
  ];

  bool _isPlayerReady = false;
  late TextEditingController _seekToController;
  late YoutubeMetaData _videoMetaData;
  late var videoIdd;

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(isShow == true
          ? lessons?.link
          : dataCharacters?.link ?? url ?? _ids.first)!,
      //initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();

    videoIdd = YoutubePlayer.convertUrlToId("${dataCharacters?.link}");
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  Widget get _space => const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Palette.main,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
        ),
        builder: (context, player) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                height: isShow == true ? 300 : 600,
                width: 400,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    player,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _space,
                        SizedBox(
                          width: 270,
                          child: Text(
                            isShow == true
                                ? '${lessons?.title} '
                                : '${dataCharacters?.summary}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'GHEAGrapalat',
                              letterSpacing: 1,
                              color: Color.fromRGBO(84, 112, 126, 1),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              isShow == true
                  ? Divider(
                      color: Color.fromRGBO(226, 224, 224, 1),
                      height: 15.0,
                      thickness: 1,
                    )
                  : Container(
                      height: 0.01,
                    ),
              isShow == true
                  ? Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      color: const Color.fromRGBO(246, 246, 246, 1),
                      width: double.infinity,
                      height: 49,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print('kisvel');
                            },
                            child: Row(
                              children: [
                                //  const SizedBox(width: 16),
                                SvgPicture.asset('assets/images/այքըններ.svg'),
                                const SizedBox(width: 6),
                                const Text('Կիսվել')
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              print('share anel paterin');
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/վելացնել1.svg'),
                                const SizedBox(width: 6),
                                const Text('Պահել'),
                                //const SizedBox(width: 16),
                              ],
                            ),
                          ),
                        ],
                      ))
                  : Container(
                      height: 0.01,
                    ),
            ],
          );
        });
  }
}
