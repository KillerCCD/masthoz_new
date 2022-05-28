import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';
import 'package:mashtoz_flutter/domens/models/book_data/content_list.dart';
import 'package:mashtoz_flutter/domens/models/book_data/word_of_day.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';

import 'package:mashtoz_flutter/ui/widgets/helper_widgets/menuShow.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/bottom_bars_pages/bottom_bar_menu_pages.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/books_page.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/audio_library/audio_library.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';

import '../../helper_widgets/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WordOfDay?>? wordsOfDayFuture;
  final bookDataProvider = BookDataProvider();
  @override
  void initState() {
    wordsOfDayFuture = bookDataProvider.getWordsOfDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.screenHeight! * 0.82);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.textLineOrBackGroundColor,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            // SliverToBoxAdapter(
            //   child: Stack(
            //     children: [

            //     ],
            //   ),
            // ),
            // SliverAppBar(
            //   flexibleSpace: Padding(
            //     padding: const EdgeInsets.only(left: 20),
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         'Օրվա խոսք',
            //         style: TextStyle(
            //             fontSize: 20,
            //             letterSpacing: 1,
            //             fontFamily: 'GHEAGrapalat',
            //             fontWeight: FontWeight.bold,
            //             color: Palette.appBarTitleColor),
            //       ),
            //     ),
            //   ),
            //   expandedHeight: 53,
            //   backgroundColor: Palette.textLineOrBackGroundColor,
            //   elevation: 0,
            //   automaticallyImplyLeading: false,
            //   systemOverlayStyle: SystemUiOverlayStyle(
            //       statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 20),
            //       child: MenuShow(),
            //     ),
            //   ],
            // ),
            SliverFillRemaining(
              child: Center(
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Center(
                    child: Column(
                      children: [
                        Positioned.fill(
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                  height: 53,
                                  width: SizeConfig.screenWidth! >= 1200
                                      ? 1200
                                      : SizeConfig.screenWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Օրվա խոսք',
                                        style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            fontFamily: 'GHEAGrapalat',
                                            fontWeight: FontWeight.bold,
                                            color: Palette.appBarTitleColor),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: MenuShow(),
                                      ),
                                    ],
                                  ),
                                ))),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth! >= 1200
                                  ? (SizeConfig.screenWidth! - 1200) / 1.9
                                  : 20.0),
                          height: 44,
                          width: SizeConfig.screenWidth,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Palette.whenTapedButton,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        blurRadius: 1.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(-4, 4),
                                      ),
                                    ]),
                                width: 50,
                                height: 44,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('25')),
                              ),
                              SizedBox(width: 14.0),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(113, 141, 156, 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          blurRadius: 1.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(-4, 4),
                                        ),
                                      ]),
                                  height: 44,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 14.0),
                                      Text(
                                        'Օրվա խոսք',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1,
                                            color: Palette
                                                .textLineOrBackGroundColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14),
                        Container(
                          height: 339,
                          width: SizeConfig.screenWidth! >= 1200
                              ? 1200
                              : SizeConfig.screenWidth,
                          color: Palette.textLineOrBackGroundColor,
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: 20.0, left: 20.0),
                                color: Color.fromRGBO(246, 246, 246, 1),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 16.0, right: 16.0),
                                                height: 50,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    'Սոս Սարգսյան',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )))),
                                    Positioned.fill(
                                      top: 14.0,
                                      left: 16.0,
                                      right: 7.0,
                                      bottom: 61,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                            color: Color.fromRGBO(
                                                246, 246, 246, 1),
                                            width: double.infinity,
                                            height: 264,
                                            child: Scrollbar(
                                                thickness: 1.5,
                                                radius:
                                                    const Radius.circular(12),
                                                isAlwaysShown: false,
                                                showTrackOnHover: true,
                                                child: FutureBuilder<
                                                        WordOfDay?>(
                                                    future: wordsOfDayFuture,
                                                    builder:
                                                        (context, snapshot) {
                                                      var data = snapshot.data;
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Container(
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                          color: Palette.main,
                                                        )));
                                                      } else if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                              'Error');
                                                        } else if (snapshot
                                                            .hasData) {
                                                          return Center(
                                                              child: ListView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            shrinkWrap: true,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                child: Text(
                                                                    '${data?.summary}'),
                                                              )
                                                            ],
                                                          ));
                                                        } else {
                                                          return const Text(
                                                              'Empty data');
                                                        }
                                                      } else {
                                                        return Text(
                                                            'State: ${snapshot.connectionState}');
                                                      }
                                                    }))),
                                      ),
                                    ),
                                    Positioned.fill(
                                        bottom: 50,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, left: 20.0),
                                            child: Divider(
                                              thickness: 1,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            // height:
                            //     SizeConfig.orentation == Orientation.landscape
                            //         ? (SizeConfig.screenHeight! * 0.82) * 2
                            height: SizeConfig.screenHeight! * 0.82,
                            width: SizeConfig.screenWidth! >= 1200
                                ? 1200
                                : SizeConfig.screenWidth,
                            color: Palette.textLineOrBackGroundColor,
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    top: 24.0,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Վերջին նորությունները',
                                          style: TextStyle(
                                              fontFamily: 'GHEAGrapalat',
                                              fontSize: 16.0,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1)),
                                        ))),
                                Positioned.fill(
                                    top: 62.0,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Գրադարան',
                                          style: TextStyle(
                                              fontFamily: 'GHEAGrapalat',
                                              fontSize: 16.0,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1)),
                                        ))),
                                Positioned.fill(
                                  top: 70,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: double.infinity,
                                      child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio:
                                                SizeConfig.orentation ==
                                                        Orientation.portrait
                                                    ? 1.7
                                                    : (1 / .4),
                                            crossAxisCount:
                                                SizeConfig.orentation ==
                                                        Orientation.portrait
                                                    ? 1
                                                    : 2,
                                            crossAxisSpacing: 15,
                                          ),
                                          addAutomaticKeepAlives: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: 2,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return BookCard(
                                                isOdd: false,
                                                categorys: BookCategory(
                                                    categoryTitle:
                                                        'ՀԱՏԸՆՏԻՐ ՀԱՏՎԱԾՆԵՐ ՈՐՈԳԻՆԵՍ Ա. ԱԼԵՔՍԱՆԴՐԱՑՈՒ ԱՇԽԱՏՈՒԹՅՈՒՆՆԵՐԻՑ',
                                                    id: 1,
                                                    title:
                                                        'Որոգինես Ադամանցիուս Ալեքսանդրացի (185-253)',
                                                    type: 'libraries'),
                                                book: Content(
                                                  videoLink: null,
                                                  content: null,
                                                  body: '',
                                                  id: 1,
                                                  image:
                                                      'https://picsum.photos/200',
                                                  title:
                                                      'Որոգինես Ադամանցիուս Ալեքսանդրացի (185-253)',
                                                  author:
                                                      'ՀԱՏԸՆՏԻՐ ՀԱՏՎԱԾՆԵՐ ՈՐՈԳԻՆԵՍ Ա. ԱԼԵՔՍԱՆԴՐԱՑՈՒ ԱՇԽԱՏՈՒԹՅՈՒՆՆԵՐԻՑ',
                                                  explanation: '',
                                                ));
                                          }),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  bottom: 16,
                                  right: 10,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((_) =>
                                                    LibraryPage())));
                                      },
                                      child: Text(
                                        'Տեսնել բոլորը',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontSize: 12.0,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w400,
                                            color: Palette.main),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.only(right: 16.0, left: 16.0),
                          // height: SizeConfig.orentation == Orientation.landscape
                          //     ? (SizeConfig.screenHeight! * 0.52) * 2
                          height: SizeConfig.screenHeight! * 0.52,
                          color: Color.fromRGBO(226, 224, 224, 1),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: SizeConfig.screenWidth! >= 1200
                                      ? 1200
                                      : SizeConfig.screenWidth,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        top: 65.0,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: 485,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'https://mashtoz.org/storage/files/1280px-engelsburg-und-engelsbrucke-abends.jpg',
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                          // height: SizeConfig
                                                          //             .orentation ==
                                                          //         Orientation
                                                          //             .landscape
                                                          //     ? (SizeConfig
                                                          //                 .screenHeight! /
                                                          //             3.55) *
                                                          //         2
                                                          height: SizeConfig
                                                                  .screenHeight! /
                                                              3.55,
                                                        ),
                                                      ),
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              YoutubePlayers()));
                                                            },
                                                            child: Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  Colors.white,
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
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: ((_) =>
                                                                    ItalianPage())));
                                                      },
                                                      child: Text(
                                                        '0007- Որոշյալ և անորոշ հոդերը ',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'GHEAGrapalat',
                                                            fontSize: 14.0,
                                                            letterSpacing: 1,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                          top: 16.0,
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Իտալերենի դասեր',
                                                style: TextStyle(
                                                    fontFamily: 'GHEAGrapalat',
                                                    fontSize: 16.0,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        122, 108, 115, 1)),
                                              ))),
                                      Positioned.fill(
                                          right: 15,
                                          bottom: 16.0,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((_) =>
                                                            ItalianPage())));
                                              },
                                              child: Text(
                                                'Տեսնել բոլորը',
                                                style: TextStyle(
                                                    fontFamily: 'GHEAGrapalat',
                                                    fontSize: 12.0,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.w400,
                                                    color: Palette.main),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // height: SizeConfig.orentation == Orientation.landscape
                          //     ? (SizeConfig.screenHeight! * 0.433) * 2
                          height: SizeConfig.screenHeight! * 0.433,
                          width: double.infinity,
                          color: Palette.textLineOrBackGroundColor,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: SizeConfig.screenWidth! >= 1200
                                      ? 1200
                                      : SizeConfig.screenWidth,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          right: 16,
                                          top: 24,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0, left: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Հանրագիտարան',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'GHEAGrapalat',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 1,
                                                        color: Color.fromRGBO(
                                                            164, 171, 189, 1)),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {},
                                                      child: SvgPicture.asset(
                                                          'assets/images/arrow_right.svg')),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Պ,Փ,Ք',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'GHEAGrapalat',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          letterSpacing: 1,
                                                          color: Color.fromRGBO(
                                                              164,
                                                              171,
                                                              189,
                                                              1)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                      Positioned.fill(
                                        bottom: 15,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            height: 81.0,
                                            width: double.infinity,

                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/VectorLine.svg',
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        child: Text(
                                                          'Պատրիարքներ Կաթողիկէ Հայոց (անուանացանկ)',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'GHEAGrapalat',
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            letterSpacing: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    113,
                                                                    141,
                                                                    156,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // child: Stack(
                                            //   children: [
                                            //     Container(
                                            //       height: double.infinity,
                                            //       width: 84,
                                            //       color: Colors.pink,
                                            //     ),
                                            //   ],
                                            // ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                top: 73,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    //color: Palette.textLineOrBackGroundColor,
                                    height: 110,
                                    width: double.infinity,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Positioned.fill(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  height: 34,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          113, 141, 156, 1),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.1),
                                                          blurRadius: 1.0,
                                                          spreadRadius: 0.0,
                                                          offset: Offset(4, 4),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                height: 34,
                                                padding: EdgeInsets.only(
                                                    right: 20.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: ListView.separated(
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    itemCount: 3,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        height: 34,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        113,
                                                                        141,
                                                                        156,
                                                                        1),
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.1),
                                                                blurRadius: 1.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset: Offset(
                                                                    4, 4),
                                                              ),
                                                            ]),
                                                        child: Center(
                                                          child: Text('Պ'),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        // Positioned.fill(
                                        //   child: Align(
                                        //     alignment: Alignment.center,
                                        //     child: Container(
                                        //       width: SizeConfig.screenWidth! >=
                                        //               1200
                                        //           ? 1200
                                        //           : SizeConfig.screenWidth,
                                        //       height: 34,
                                        //       padding:
                                        //           EdgeInsets.only(right: 20.0),
                                        //       child: Align(
                                        //         alignment:
                                        //             Alignment.centerRight,
                                        //         child: ListView.separated(
                                        //           separatorBuilder:
                                        //               (context, index) =>
                                        //                   SizedBox(
                                        //             width: 10.0,
                                        //           ),
                                        //           itemCount: 3,
                                        //           shrinkWrap: true,
                                        //           scrollDirection:
                                        //               Axis.horizontal,
                                        //           physics:
                                        //               NeverScrollableScrollPhysics(),
                                        //           itemBuilder:
                                        //               (context, index) {
                                        //             return Container(
                                        //               height: 34,
                                        //               width: 45,
                                        //               decoration: BoxDecoration(
                                        //                   color: Color.fromRGBO(
                                        //                       113, 141, 156, 1),
                                        //                   boxShadow: [
                                        //                     BoxShadow(
                                        //                       color: Color
                                        //                           .fromRGBO(
                                        //                               0,
                                        //                               0,
                                        //                               0,
                                        //                               0.1),
                                        //                       blurRadius: 1.0,
                                        //                       spreadRadius: 0.0,
                                        //                       offset:
                                        //                           Offset(4, 4),
                                        //                     ),
                                        //                   ]),
                                        //               child: Center(
                                        //                 child: Text('Պ'),
                                        //               ),
                                        //             );
                                        //           },
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Center(
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            width:
                                                SizeConfig.screenWidth! >= 1200
                                                    ? 1200
                                                    : SizeConfig.screenWidth,
                                            child: Stack(
                                              children: [
                                                // Positioned.fill(
                                                //     child: Align(
                                                //   alignment:
                                                //       Alignment.centerLeft,
                                                //   child: Container(
                                                //     decoration: BoxDecoration(
                                                //         color: Color.fromRGBO(
                                                //             113, 141, 156, 1),
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color:
                                                //                 Color.fromRGBO(
                                                //                     0,
                                                //                     0,
                                                //                     0,
                                                //                     0.1),
                                                //             blurRadius: 1.0,
                                                //             spreadRadius: 0.0,
                                                //             offset:
                                                //                 Offset(4, 4),
                                                //           ),
                                                //         ]),
                                                //     height: 34,
                                                //     width: SizeConfig
                                                //                 .screenWidth! >=
                                                //             1200
                                                //         ? 1000
                                                //         : SizeConfig
                                                //                 .screenWidth! -
                                                //             200,
                                                //   ),
                                                // )),
                                                Container(
                                                  height: double.infinity,
                                                  width: 84,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          84, 126, 126, 1),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.1),
                                                          blurRadius: 1.0,
                                                          spreadRadius: 0.0,
                                                          offset: Offset(4, 4),
                                                        ),
                                                      ]),
                                                  child: Center(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15.0),
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        child: Text(
                                                          'Պ',
                                                          style: TextStyle(
                                                              color: Palette
                                                                  .whenTapedButton,
                                                              fontFamily:
                                                                  'ArshaluyseArtU',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 52),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          color: Color.fromRGBO(226, 224, 224, 1),
                          // height: SizeConfig.orentation == Orientation.landscape
                          //     ? (SizeConfig.screenHeight! * 0.65) * 2
                          height: SizeConfig.screenHeight! * 0.65,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: SizeConfig.screenWidth! >= 1200
                                      ? 1200
                                      : SizeConfig.screenWidth,
                                  child: Positioned.fill(
                                      right: 16,
                                      top: 16,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ձայանդարան',
                                                style: TextStyle(
                                                    fontFamily: 'GHEAGrapalat',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 1,
                                                    color: Color.fromRGBO(
                                                        122, 108, 115, 1)),
                                              ),
                                              SizedBox(width: 17),
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: SvgPicture.asset(
                                                    'assets/images/arrow_right.svg',
                                                    color: Color.fromRGBO(
                                                        122, 108, 115, 1),
                                                  )),
                                              SizedBox(width: 17),
                                              Text(
                                                'Ե',
                                                style: TextStyle(
                                                    fontFamily: 'GHEAGrapalat',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 1,
                                                    color: Color.fromRGBO(
                                                        122, 108, 115, 1)),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              Positioned.fill(
                                  top: 49,
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: SizeConfig.screenWidth! >= 1200
                                            ? 1200
                                            : SizeConfig.screenWidth,
                                        // height: SizeConfig.orentation ==
                                        //         Orientation.landscape
                                        //     ? (SizeConfig.screenHeight! *
                                        //             0.101) *
                                        //         2
                                        height:
                                            SizeConfig.screenHeight! * 0.101,
                                        child: Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:
                                                    SizeConfig.screenWidth! >=
                                                            1200
                                                        ? 100
                                                        : 60,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        83, 66, 77, 1),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.1),
                                                        blurRadius: 1.0,
                                                        spreadRadius: 0.0,
                                                        offset: Offset(4, 4),
                                                      ),
                                                    ]),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Պ',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "ArshaluyseArtU",
                                                      fontSize: SizeConfig
                                                                  .screenWidth! >=
                                                              1200
                                                          ? 38
                                                          : 30,
                                                      color: Palette
                                                          .textLineOrBackGroundColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                      left: 10.0,
                                                    ),
                                                    child: Text(
                                                      'Շուլեմ Լեմմեր և Շիռա երգչախումբ, «Հայր մեր, Թագավոր մեր, լսիր մեր ձայնը»',
                                                      //  softWrap: true,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            83, 66, 77, 1),
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              Align(
                                child: Container(
                                  width: SizeConfig.screenWidth! >= 1200
                                      ? 1200
                                      : SizeConfig.screenWidth,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        top: 167.0,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: 485,

                                            // height: SizeConfig.orentation ==
                                            //         Orientation.landscape
                                            //     ? (SizeConfig.screenHeight! /
                                            //             3.55) *
                                            //         2
                                            height:
                                                SizeConfig.screenHeight! / 3.55,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://mashtoz.org/storage/files/1280px-engelsburg-und-engelsbrucke-abends.jpg',
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
                                                    height: SizeConfig
                                                            .screenHeight! /
                                                        3.55,
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .push(MaterialPageRoute(
                                                                builder: (_) =>
                                                                    YoutubePlayers()));
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((_) => AudioLibrary())));
                                  },
                                  child: Text(
                                    'Տեսնել բոլորը',
                                    style: TextStyle(
                                        fontFamily: 'GHEAGrapalat',
                                        fontSize: 12.0,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w400,
                                        color: Palette.main),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          // height: SizeConfig.orentation == Orientation.landscape
                          //     ? (SizeConfig.screenHeight! * 0.7) * 2
                          height: SizeConfig.screenHeight! * 0.7,
                          width: double.infinity,
                          color: Palette.textLineOrBackGroundColor,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: SizeConfig.screenWidth! >= 1200
                                      ? 1200
                                      : SizeConfig.screenWidth,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          right: 16,
                                          top: 24,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0, left: 16.0),
                                              child: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Համաբարբառ ',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'GHEAGrapalat',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          letterSpacing: 1,
                                                          color: Color.fromRGBO(
                                                              164,
                                                              171,
                                                              189,
                                                              1)),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {},
                                                        child: SvgPicture.asset(
                                                            'assets/images/arrow_right.svg')),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      'Պ,Փ,Ք',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'GHEAGrapalat',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          letterSpacing: 1,
                                                          color: Color.fromRGBO(
                                                              164,
                                                              171,
                                                              189,
                                                              1)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      Positioned.fill(
                                        top: 194.0,
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                              width: SizeConfig.screenWidth! >=
                                                      1200
                                                  ? 1200
                                                  : SizeConfig.screenWidth,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          16.0),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.3,
                                                              child: Text(
                                                                'Ազատուել (կամ նաեւ Ազատագրուել)',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'GHEAGrapalat',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            97,
                                                                            109,
                                                                            135,
                                                                            1)),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                top: 73,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 110,
                                    width: double.infinity,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Positioned.fill(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  height: 34,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          113, 141, 156, 1),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.1),
                                                          blurRadius: 1.0,
                                                          spreadRadius: 0.0,
                                                          offset: Offset(4, 4),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                height: 34,
                                                padding: EdgeInsets.only(
                                                    right: 20.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: ListView.separated(
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    itemCount: 3,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        height: 34,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        113,
                                                                        141,
                                                                        156,
                                                                        1),
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.1),
                                                                blurRadius: 1.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset: Offset(
                                                                    4, 4),
                                                              ),
                                                            ]),
                                                        child: Center(
                                                          child: Text('Պ'),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        Center(
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            width:
                                                SizeConfig.screenWidth! >= 1200
                                                    ? 1200
                                                    : SizeConfig.screenWidth,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: double.infinity,
                                                  width: 84,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          84, 126, 126, 1),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.1),
                                                          blurRadius: 1.0,
                                                          spreadRadius: 0.0,
                                                          offset: Offset(4, 4),
                                                        ),
                                                      ]),
                                                  child: Center(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15.0),
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        child: Text(
                                                          'Պ',
                                                          style: TextStyle(
                                                              color: Palette
                                                                  .whenTapedButton,
                                                              fontFamily:
                                                                  'ArshaluyseArtU',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 52),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  top: 264.0,
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 150,
                                        width: double.infinity,
                                        color: Colors.red,
                                        child: Container(
                                          color:
                                              Color.fromRGBO(197, 202, 212, 1),
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  // constraints: BoxConstraints.expand(),
                                                  color: Color.fromRGBO(
                                                      164, 171, 189, 1),
                                                  height: 50,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 28.0),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text('Երեմիա')),
                                                  )),
                                              ListView.separated(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      child: IntrinsicHeight(
                                                          child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            child:
                                                                Wrap(children: [
                                                              Text(
                                                                "27, 20",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                softWrap: true,
                                                              ),
                                                            ]),
                                                          ),
                                                          VerticalDivider(
                                                            color: Colors.black,
                                                            thickness: 1,
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Container(
                                                                  child: Text(
                                                                '« ... Երուսաղէմի ողջ ազատանուն գերի տարաւ ... »',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              )),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    );
                                                  },
                                                  separatorBuilder: (context,
                                                          index) =>
                                                      SizedBox(height: 20.0),
                                                  itemCount: 1),
                                            ],
                                          ),
                                        ),
                                      ))),
                              Positioned.fill(
                                  right: 15,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((_) =>
                                                    ItalianPage())));
                                      },
                                      child: Text(
                                        'Տեսնել բոլորը',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontSize: 12.0,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w400,
                                            color: Palette.main),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//!!hamabarbar
 // Positioned.fill(
                              //     right: 16,
                              //     top: 24,
                              //     child: Align(
                              //       alignment: Alignment.topCenter,
                              //       child: Padding(
                              //         padding: const EdgeInsets.only(
                              //             right: 16.0, left: 16.0),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.start,
                              //           children: [
                              //             Expanded(
                              //               child: Text(
                              //                 'Համաբարբառ ',
                              //                 style: TextStyle(
                              //                   fontFamily: 'GHEAGrapalat',
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w700,
                              //                   letterSpacing: 1,
                              //                   color: Color.fromRGBO(
                              //                       164, 171, 189, 1),
                              //                 ),
                              //                 textAlign: TextAlign.start,
                              //               ),
                              //             ),
                              //             GestureDetector(
                              //                 onTap: () {},
                              //                 child: SvgPicture.asset(
                              //                     'assets/images/arrow_right.svg')),
                              //             SizedBox(
                              //               width: 10.0,
                              //             ),
                              //             Expanded(
                              //               child: Text(
                              //                 'Ո,Հ,Թ',
                              //                 style: TextStyle(
                              //                     fontFamily: 'GHEAGrapalat',
                              //                     fontSize: 12,
                              //                     fontWeight: FontWeight.w700,
                              //                     letterSpacing: 1,
                              //                     color: Color.fromRGBO(
                              //                         164, 171, 189, 1)),
                              //               ),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     )),
//!! inkwell
//  InkWell(
//                       onTap: () {
//                         setState(() {
//                           _toggleDrawer();

//                         });
//                         showGeneralDialog(
//                             context: context,
//                             barrierDismissible: true,
//                             barrierColor: Colors.black.withOpacity(0.1),
//                             transitionDuration: Duration(microseconds: 500),
//                             barrierLabel:
//                                 MaterialLocalizations.of(context).dialogLabel,
//                             pageBuilder: (
//                               context,
//                               _,
//                               __,
//                             ) {
//                               return Column(
//                                 children: [
//                                   Container(
//                                       color: Colors.red,
//                                       width:
//                                           MediaQuery.of(context).size.width,
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               1.08,
//                                       child: Scaffold(
//                                         body: AppBar(
//                                           title: SvgPicture.asset(
//                                               'assets/images/mashtoz_org.svg'),
//                                           leading: Container(),
//                                           toolbarHeight: 63,
//                                           actions: [
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   right: 20.0),
//                                               child: InkWell(
//                                                 onTap: _toggleDrawer,
//                                                 child: SizedBox(
//                                                   height: 120,
//                                                   width: 30,
//                                                   child: Stack(children: [
//                                                     InkWell(
//                                                       onTap: () {
//                                                         // print('notWorking');
//                                                         _toggleDrawer();

//                                                         Navigator.pop(
//                                                             context);
//                                                       },
//                                                       child: SvgPicture.asset(
//                                                         'assets/images/app_bar_icon_button.svg',

//                                                             : const Color
//                                                                     .fromRGBO(
//                                                                 122,
//                                                                 108,
//                                                                 115,
//                                                                 1),
//                                                         fit: BoxFit.cover,
//                                                         height: 90,
//                                                         //width: 60,
//                                                         //width: 22,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 80,
//                                                       width: 50,
//                                                       child: Center(
//                                                         child:
//                                                             AnimatedBuilder(
//                                                           animation:
//                                                               animation,
//                                                           builder: (context,
//                                                               child) {
//                                                             return InkWell(
//                                                               onTap: () {
//                                                                 _toggleDrawer();
//                                                                 Navigator.pop(
//                                                                     context);
//                                                               },
//                                                               child: Transform
//                                                                   .rotate(
//                                                                 angle: animation
//                                                                     .value
//                                                                     .toDouble(),
//                                                                 child: _isDrawerOpen() ||
//                                                                         _isDrawerOpening()
//                                                                     ? SvgPicture
//                                                                         .asset(
//                                                                         'assets/images/close_bar_icon.svg',
//                                                                         height:
//                                                                             15,
//                                                                         width:
//                                                                             8,
//                                                                       )
//                                                                     : SvgPicture
//                                                                         .asset(
//                                                                         'assets/images/asset_bar_icon.svg',
//                                                                         height:
//                                                                             10,
//                                                                         width:
//                                                                             8,
//                                                                       ),
//                                                               ),
//                                                             );
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ]),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )),
//                                 ],
//                               );
//                             },
//                             transitionBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               return SlideTransition(
//                                 position: CurvedAnimation(
//                                   parent: animation,
//                                   curve: Curves.easeInOutCubic,
//                                 ).drive(
//                                   Tween<Offset>(
//                                       begin: Offset(0, -1.0),
//                                       end: Offset.zero),
//                                 ),
//                                 child: child,
//                               );
//                             });
//                       },
//                       child: SvgPicture.asset(
//                         'assets/images/app_bar_icon_button.svg',

//                         color: iconAcitve
//                             ? Palette.appBarIconMenuColor
//                             : const Color.fromRGBO(122, 108, 115, 1),
//                         fit: BoxFit.cover,
//                         height: 90,
//                         //width: 60,
//                         //width: 22,
//                       ),
//                     ),                                                         color: iconAcitve
//                                                             ? Palette
//                                                                 .appBarIconMenuColor
  // Positioned.fill(
  //                                 bottom: 60.0,
  //                                 child: Align(
  //                                     alignment: Alignment.bottomRight,
  //                                     child: Container(
  //                                       height: 150,
  //                                       width: double.infinity,
  //                                       color: Colors.red,
  //                                       child: Container(
  //                                         color:
  //                                             Color.fromRGBO(197, 202, 212, 1),
  //                                         child: Column(
  //                                           children: [
  //                                             Container(
  //                                                 width: double.infinity,
  //                                                 // constraints: BoxConstraints.expand(),
  //                                                 color: Color.fromRGBO(
  //                                                     164, 171, 189, 1),
  //                                                 height: 50,
  //                                                 child: Padding(
  //                                                   padding: EdgeInsets.only(
  //                                                       left: 28.0),
  //                                                   child: Align(
  //                                                       alignment: Alignment
  //                                                           .centerLeft,
  //                                                       child: Text('Երեմիա')),
  //                                                 )),
  //                                             ListView.separated(
  //                                                 scrollDirection:
  //                                                     Axis.vertical,
  //                                                 physics:
  //                                                     ClampingScrollPhysics(),
  //                                                 shrinkWrap: true,
  //                                                 itemBuilder:
  //                                                     (context, index) {
  //                                                   return Container(
  //                                                     padding:
  //                                                         EdgeInsets.all(12.0),
  //                                                     child: IntrinsicHeight(
  //                                                         child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceBetween,
  //                                                       children: [
  //                                                         Container(
  //                                                           width: 50,
  //                                                           child:
  //                                                               Wrap(children: [
  //                                                             Text(
  //                                                               "27, 20",
  //                                                               textAlign:
  //                                                                   TextAlign
  //                                                                       .start,
  //                                                               softWrap: true,
  //                                                             ),
  //                                                           ]),
  //                                                         ),
  //                                                         VerticalDivider(
  //                                                           color: Colors.black,
  //                                                           thickness: 1,
  //                                                         ),
  //                                                         Expanded(
  //                                                           flex: 1,
  //                                                           child: Align(
  //                                                             alignment:
  //                                                                 Alignment
  //                                                                     .topCenter,
  //                                                             child: Container(
  //                                                                 child: Text(
  //                                                               '« ... Երուսաղէմի ողջ ազատանուն գերի տարաւ ... »',
  //                                                               textAlign:
  //                                                                   TextAlign
  //                                                                       .start,
  //                                                             )),
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     )),
  //                                                   );
  //                                                 },
  //                                                 separatorBuilder: (context,
  //                                                         index) =>
  //                                                     SizedBox(height: 20.0),
  //                                                 itemCount: 1),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ))),


//!!Azatuel  

                              // Positioned.fill(
                              //   top: 183.0,
                              //   child: Center(
                              //     child: Container(
                              //       width: SizeConfig.screenWidth! >= 1200
                              //           ? 1200
                              //           : SizeConfig.screenWidth,
                              //       child: Align(
                              //         alignment: Alignment.centerLeft,
                              //         child: Container(
                              //           padding: EdgeInsets.only(left: 16.0),
                              //           width:
                              //               MediaQuery.of(context).size.width /
                              //                   1.3,
                              //           child: Align(
                              //               alignment: Alignment.centerLeft,
                              //               child: Expanded(
                              //                 child: Text(
                              //                   'Ազատուել (կամ նաեւ Ազատագրուել)',
                              //                   style: TextStyle(
                              //                       fontFamily: 'GHEAGrapalat',
                              //                       fontWeight: FontWeight.w700,
                              //                       fontSize: 16.0,
                              //                       color: Color.fromRGBO(
                              //                           97, 109, 135, 1)),
                              //                   textAlign: TextAlign.start,
                              //                 ),
                              //               )),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
