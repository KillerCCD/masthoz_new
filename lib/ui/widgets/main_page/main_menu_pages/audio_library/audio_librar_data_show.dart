import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';

import 'package:mashtoz_flutter/domens/models/book_data/data.dart';

import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../domens/models/user.dart';
import '../../../../../domens/repository/user_data_provider.dart';
import '../../../helper_widgets/menuShow.dart';
import '../../../helper_widgets/save_show_dialog.dart';
import '../../../helper_widgets/size_config.dart';
import '../../bottom_bars_pages/italian_lessons_screen/italian_lesson_page.dart';

class AudioLibraryDataShow extends StatefulWidget {
  final Data? dataCharacter;
  const AudioLibraryDataShow({Key? key, this.dataCharacter}) : super(key: key);

  @override
  State<AudioLibraryDataShow> createState() =>
      _AudioLibraryDataShowState(dataCharacter: dataCharacter);
}

class _AudioLibraryDataShowState extends State<AudioLibraryDataShow> {
  var textData =
      '135, 112. 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15. 16. 17. 18. 19. 20. 21. 22. 23. 24. 25. 26';

  final Data? dataCharacter;
  int? custemerId;

  final userDataProvider = UserDataProvider();
  _AudioLibraryDataShowState({this.dataCharacter});
  @override
  void initState() {
    userDataProvider.fetchUserInfo().then((value) => custemerId = value.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    print(dataCharacter?.link);
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
                                      onTap: () async {
                                        await Share.share(dataCharacter?.link);
                                        print('kisvel');
                                        // showDialog(
                                        //     context: context,
                                        //     barrierDismissible: true,
                                        //     builder: (
                                        //       context,
                                        //     ) =>
                                        //         SaveShowDialog(
                                        //           isShow: false,
                                        //         ));
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
                                        var data = <String, dynamic>{
                                          'type': 'audiolibraries',
                                          'type_id': dataCharacter?.id,
                                          'customer_id': 38,
                                        };
                                        setState(() {
                                          userIsSign(data);
                                        });
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
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: 485,
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CachedNetworkImage(
                              imageUrl: dataCharacter!.image!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              // height: SizeConfig
                              //             .orentation ==
                              //         Orientation
                              //             .landscape
                              //     ? (SizeConfig
                              //                 .screenHeight! /
                              //             3.55) *
                              //         2
                              height: SizeConfig.screenHeight! / 3.55,
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (_) => YoutubePlayers(
                                                isShow: false,
                                                dataCharacters: dataCharacter,
                                              )));
                                },
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Text(
                          '${dataCharacter?.summary}',
                          style: TextStyle(
                              fontFamily: 'GHEAGrapalat',
                              fontSize: 14.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void userIsSign(Map<String, dynamic> data) async {
    Users hasId = await userDataProvider.fetchUserInfo();
    bool isSign = await userDataProvider.saveFavorite(data);

    if (!isSign || hasId == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (
            context,
          ) =>
              SaveShowDialog(
                isShow: true,
              ));
    }
  }
}
