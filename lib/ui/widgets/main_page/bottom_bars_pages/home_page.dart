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
    return Scaffold(
      backgroundColor: Palette.textLineOrBackGroundColor,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                flexibleSpace: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Օրվա խոսք',
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontFamily: 'GHEAGrapalat',
                        fontWeight: FontWeight.bold,
                        color: Palette.appBarTitleColor),
                  ),
                ),
                expandedHeight: 53,
                backgroundColor: Palette.textLineOrBackGroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
                actions: [
                  MenuShow(),
                ],
              ),
              SliverFillRemaining(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 5.0),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Palette.whenTapedButton,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(31, 31, 31, 0.5),
                                        blurRadius: 1.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(-1.5, 3),
                                      ),
                                    ]),
                                width: 50,
                                height: 44,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('25')),
                              ),
                              SizedBox(width: 17),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(113, 141, 156, 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(31, 31, 31, 0.5),
                                          blurRadius: 1.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(-1.5, 3),
                                        ),
                                      ]),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 12.0),
                                    child: Text(
                                      'Օրվա խոսք',
                                      style: TextStyle(
                                          fontFamily: 'GHEAGrapalat',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 14),
                      Container(
                        color: Color.fromRGBO(246, 246, 246, 1),
                        height: 380,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                                color: Color.fromRGBO(246, 246, 246, 1),
                                width: double.infinity,
                                padding: EdgeInsets.all(16.0),
                                height: 320,
                                child: Scrollbar(
                                    thickness: 1.5,
                                    radius: const Radius.circular(12),
                                    isAlwaysShown: false,
                                    showTrackOnHover: true,
                                    child: FutureBuilder<WordOfDay?>(
                                        future: wordsOfDayFuture,
                                        builder: (context, snapshot) {
                                          var data = snapshot.data;
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Container(
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              color: Palette.main,
                                            )));
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasError) {
                                              return const Text('Error');
                                            } else if (snapshot.hasData) {
                                              return Center(
                                                  child: ListView(
                                                children: [
                                                  Text('${data?.summary}')
                                                ],
                                              ));
                                            } else {
                                              return const Text('Empty data');
                                            }
                                          } else {
                                            return Text(
                                                'State: ${snapshot.connectionState}');
                                          }
                                        }))),
                            Positioned.fill(
                                bottom: 50,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16.0, left: 16.0),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                )),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        height: 50,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Սոս Սարգսյան',
                                            textAlign: TextAlign.center,
                                          ),
                                        )))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                          height: 430,
                          width: double.infinity,
                          color: Palette.textLineOrBackGroundColor,
                          child: Stack(
                            children: [
                              Container(
                                height: 400,
                                width: double.infinity,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          BookCard(
                                            isOdd: false,
                                            categorys: BookCategory(
                                                categoryTitle: 'suka',
                                                id: 1,
                                                title: 'dadasion',
                                                type: 'libraries'),
                                            book: Content(
                                              videoLink: null,
                                              content: null,
                                              body: '',
                                              id: 1,
                                              image:
                                                  'https://picsum.photos/200',
                                              title: 'Davidi Verchi xosqy',
                                              author: 'Davit Mcarenc',
                                              explanation: '',
                                            ),
                                          ),
                                          SizedBox(height: 30.0),
                                        ],
                                      );
                                    }),
                              ),
                              Positioned.fill(
                                bottom: 16,
                                right: 30,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((_) => LibraryPage())));
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
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        height: 333,
                        color: Color.fromRGBO(226, 224, 224, 1),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                    color: Colors.blue,
                                    height: 200,
                                    child: YoutubePlayers()),
                              ),
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Իտալերենի դասեր'))),
                            Positioned.fill(
                                child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((_) => ItalianPage())));
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
                        height: 276,
                        width: double.infinity,
                        color: Palette.textLineOrBackGroundColor,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                right: 16,
                                top: 24,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Հանրագիտարան',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                            color: Color.fromRGBO(
                                                164, 171, 189, 1)),
                                      ),
                                      GestureDetector(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                              'assets/images/arrow_right.svg')),
                                      Text(
                                        'Պ,Փ,Ք',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                            color: Color.fromRGBO(
                                                164, 171, 189, 1)),
                                      )
                                    ],
                                  ),
                                )),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  color: Palette.textLineOrBackGroundColor,
                                  height: 110,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          color:
                                              Color.fromRGBO(113, 141, 156, 1),
                                          height: 34,
                                          width: 150,
                                        ),
                                      )),
                                      Positioned.fill(
                                        right: 10.0,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 34,
                                            width: 153,
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                width: 10.0,
                                              ),
                                              itemCount: 3,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: 34,
                                                  width: 45,
                                                  color: Color.fromRGBO(
                                                      113, 141, 156, 1),
                                                  child: Center(
                                                    child: Text('Պ'),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 16.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: double.infinity,
                                              width: 84,
                                              color: Color.fromRGBO(
                                                  84, 112, 126, 1),
                                              child: Center(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
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
                                                              FontWeight.w700,
                                                          fontSize: 52),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
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
                                              child: Text(
                                                'Պատրիարքներ Կաթողիկէ Հայոց (անուանացանկ)',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'GHEAGrapalat',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1,
                                                  color: Color.fromRGBO(
                                                      113, 141, 156, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
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
                      Container(
                        padding: EdgeInsets.all(16.0),
                        color: Color.fromRGBO(226, 224, 224, 1),
                        height: 416,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                right: 16,
                                top: 24,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                )),
                            Positioned(
                              top: 65,
                              child: Container(
                                  height: 63,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Color.fromRGBO(83, 66, 77, 1),
                                        height: 63,
                                        width: 50,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Պ',
                                            style: TextStyle(
                                                fontFamily: "ArshaluyseArtU",
                                                fontSize: 30.0,
                                                color: Palette
                                                    .textLineOrBackGroundColor,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          'Շուլեմ Լեմմեր և Շիռա երգչախումբ, «Հայր մեր, Թագավոր մեր, լսիր մեր ձայնը»',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(83, 66, 77, 1),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ))
                                    ],
                                  )),
                            ),
                            Positioned.fill(
                              bottom: 40,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    color: Colors.blue,
                                    height: 177,
                                    child: YoutubePlayers()),
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
                        height: 500,
                        width: double.infinity,
                        color: Palette.textLineOrBackGroundColor,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                right: 16,
                                top: 24,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Համաբարբառ ',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                            color: Color.fromRGBO(
                                                164, 171, 189, 1)),
                                      ),
                                      GestureDetector(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                              'assets/images/arrow_right.svg')),
                                      Text(
                                        'Ո,Հ,Թ',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                            color: Color.fromRGBO(
                                                164, 171, 189, 1)),
                                      )
                                    ],
                                  ),
                                )),
                            Positioned.fill(
                              top: 65,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  color: Palette.textLineOrBackGroundColor,
                                  height: 110,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          color:
                                              Color.fromRGBO(113, 141, 156, 1),
                                          height: 34,
                                          width: 150,
                                        ),
                                      )),
                                      Positioned.fill(
                                        right: 10.0,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 34,
                                            width: 153,
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                width: 10.0,
                                              ),
                                              itemCount: 3,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: 34,
                                                  width: 45,
                                                  color: Color.fromRGBO(
                                                      113, 141, 156, 1),
                                                  child: Center(
                                                    child: Text('Ո'),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 16.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: double.infinity,
                                              width: 84,
                                              color: Color.fromRGBO(
                                                  84, 112, 126, 1),
                                              child: Center(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
                                                        top: 15.0),
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    child: Text(
                                                      'Ո',
                                                      style: TextStyle(
                                                          color: Palette
                                                              .whenTapedButton,
                                                          fontFamily:
                                                              'ArshaluyseArtU',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 52),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 40.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  width: double.infinity,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Ազատուել (կամ նաեւ Ազատագրուել)',
                                        style: TextStyle(
                                            fontFamily: 'GHEAGrapalat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            color: Color.fromRGBO(
                                                97, 109, 135, 1)),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                              ),
                            ),
                            Positioned.fill(
                                bottom: 60.0,
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      color: Colors.red,
                                      child: Container(
                                        color: Color.fromRGBO(197, 202, 212, 1),
                                        child: Column(
                                          children: [
                                            Container(
                                                width: double.infinity,
                                                // constraints: BoxConstraints.expand(),
                                                color: Color.fromRGBO(
                                                    164, 171, 189, 1),
                                                height: 44,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 28.0),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('Երեմիա')),
                                                )),
                                            ListView.separated(
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
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
                                                            alignment: Alignment
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
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(height: 20.0),
                                                itemCount: 1),
                                          ],
                                        ),
                                      ),
                                    ))),
                            Positioned.fill(
                                bottom: 20.0,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((_) => LibraryPage())));
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
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
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
