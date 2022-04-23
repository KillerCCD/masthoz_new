import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dictionary_screen/dictionary.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';

class AudioLibraryDataShow extends StatefulWidget {
  final ByCharacters? dataCharacter;
  const AudioLibraryDataShow({Key? key, this.dataCharacter}) : super(key: key);

  @override
  State<AudioLibraryDataShow> createState() =>
      _AudioLibraryDataShowState(dataCharacter: dataCharacter);
}

class _AudioLibraryDataShowState extends State<AudioLibraryDataShow> {
  var textData =
      '135, 112. 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15. 16. 17. 18. 19. 20. 21. 22. 23. 24. 25. 26';

  final ByCharacters? dataCharacter;
  _AudioLibraryDataShowState({this.dataCharacter});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            expandedHeight: 73,
            backgroundColor: Palette.textLineOrBackGroundColor,
            pinned: false,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            flexibleSpace: ActionsHelper(
              leftPadding: 12,
              // botomPadding: 0,
              // topPadding: 30,
              text: '${dataCharacter?.firstCharacter}',

              fontFamily: 'Grapalat',
              fontSize: 20,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.appBarTitleColor,
              buttonShow: true,
            ),
          ),
          // SliverFillRemaining(
          //   // child: YoutubePlayers(
          //   //   lessons: lessons,
          //   // ),
          //   child: Container(
          //     child: Center(
          //       child: Text('DAvs'),
          //     ),
          //   ),
          // ),
          //! Ձայնադարան

          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: mediaQuery.width,
                  height: 275,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 90,
                          left: 0,
                          child: Container(
                              width: mediaQuery.width,
                              height: 185,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(164, 171, 189, 1),
                              ))),
                      Container(
                          child: Center(
                        child: SizedBox(
                            width: 300,
                            height: mediaQuery.height / 2,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 300,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        border: Border.all(
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                          width: 01,
                                        ),
                                      ))),
                              Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    width: 283,
                                    height: 164,
                                    // child: Text('Marjanja'),
                                    child: CachedNetworkImage(
                                      imageUrl: "${dataCharacter?.image}",
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ])),
                      )),
                      Positioned(
                          top: 193,
                          left: mediaQuery.width / 5,
                          child: Container(
                            width: 246,
                            child: Text(
                              "${dataCharacter?.title}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(25, 4, 18, 1),
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                    color: const Color.fromRGBO(246, 246, 246, 1),
                    width: double.infinity,
                    height: 49,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            print('kisvel');
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              SvgPicture.asset('assets/images/այքըններ.svg'),
                              const SizedBox(width: 6),
                              const Text('Կիսվել')
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('share anel paterin');
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/վելացնել1.svg'),
                              const SizedBox(width: 6),
                              const Text('Պահել'),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 30),
                // YoutubePlayers(),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                YoutubePlayers(
                  dataCharacters: dataCharacter,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
