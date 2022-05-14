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

import '../../../helper_widgets/menuShow.dart';
import '../../../helper_widgets/save_show_dialog.dart';

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
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height,
      child: Scaffold(
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            // SliverAppBar(
            //   expandedHeight: 73,
            //   backgroundColor: Palette.textLineOrBackGroundColor,
            //   pinned: false,
            //   floating: true,
            //   elevation: 0,
            //   automaticallyImplyLeading: false,
            //   systemOverlayStyle: SystemUiOverlayStyle(
            //       statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            //   flexibleSpace: ActionsHelper(
            //     leftPadding: 12,
            //     // botomPadding: 0,
            //     // topPadding: 30,
            //     text: '${dataCharacter?.firstCharacter}',

            //     fontFamily: 'GHEAGrapalat',
            //     fontSize: 20,
            //     laterSpacing: 1,
            //     fontWeight: FontWeight.bold,
            //     color: Palette.appBarTitleColor,
            //     buttonShow: true,
            //   ),
            // ),
            SliverAppBar(
              flexibleSpace: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, top: 5.0),
                  child: Text(
                    '${dataCharacter?.firstCharacter}',
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                        fontFamily: 'GHEAGrapalat',
                        fontWeight: FontWeight.w700,
                        color: Palette.appBarTitleColor),
                  ),
                ),
              ),
              pinned: false,
              floating: true,
              leading: SizedBox(
                width: 8,
                height: 14.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Palette.appBarTitleColor,
                  ),
                ),
              ),
              expandedHeight: 73,
              backgroundColor: Palette.textLineOrBackGroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: MenuShow(),
                ),
              ],
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
              child: Stack(
                children: [
                  Container(
                    width: mediaQuery.width,
                    height: 300,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            top: 70,
                            left: 0,
                            child: Stack(
                              children: [
                                Container(
                                    width: mediaQuery.width,
                                    height: 185,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(113, 141, 156, 1),
                                    )),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 350,
                                    height: 90,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        "${dataCharacter?.title}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromRGBO(25, 4, 18, 1),
                                          fontSize: 12,
                                          fontFamily: 'GHEAGrapalat',
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            )),
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
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(51, 51, 51, 1),
                                            width: 01,
                                          ),
                                        ))),
                                Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      width: 283,
                                      height: 134,
                                      // child: Text('Marjanja'),
                                      child: CachedNetworkImage(
                                        imageUrl: "${dataCharacter?.image}",
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              ])),
                        )),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                padding:
                                    EdgeInsets.only(left: 25.0, right: 25.0),
                                color: Color.fromRGBO(246, 246, 246, 1),
                                width: double.infinity,
                                height: 49,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('kisvel');
                                           showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (
                                    context,
                                  ) =>
                                      SaveShowDialog(
                                        isShow: false,
                                      ));
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/այքըններ.svg'),
                                          const SizedBox(width: 6),
                                          const Text('Կիսվել')
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        print('share anel paterin');
                                           showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (
                                          context,
                                        ) =>
                                            SaveShowDialog(isShow: true));
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/վելացնել1.svg'),
                                          const SizedBox(width: 6),
                                          const Text('Պահել'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // YoutubePlayers(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: YoutubePlayers(
                dataCharacters: dataCharacter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
