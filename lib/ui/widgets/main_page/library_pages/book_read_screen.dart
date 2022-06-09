import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/app_theme.dart/theme_notifire.dart';
import 'package:mashtoz_flutter/domens/models/book_data/data.dart';
import 'package:mashtoz_flutter/domens/models/book_data/search_data.dart';
import 'package:mashtoz_flutter/domens/repository/search_book_data_provider.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/size_config.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_page.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../../../domens/models/book_data/content_list.dart';
import '../../helper_widgets/save_show_dialog.dart';
import 'book_inherited_widget.dart';

class BookReadScreen extends StatefulWidget {
  const BookReadScreen(
      {Key? key, this.readScreen, this.encyclopediaBody, this.searchData})
      : super(key: key);

  final Data? encyclopediaBody;
  final Content? readScreen;
  final Search? searchData;

  @override
  State<BookReadScreen> createState() => _BookReadScreenState(
      readScreen: readScreen,
      encyclopediaBody: encyclopediaBody,
      searchData: searchData);
}

class _BookReadScreenState extends State<BookReadScreen> {
  _BookReadScreenState(
      {this.readScreen, this.encyclopediaBody, this.searchData});

  final Content? readScreen;
  final Search? searchData;
  final Data? encyclopediaBody;
  Future<Data?>? futureSearchText;
  final searchBookProvider = SearchBookProvider();
  Future<Content?>? content;
  var bookPartsLengt;
  var count = 0;
  var data;
  var textList = <String>[];

  int pageindex = 0;
  bool isVisiblty = false;

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _pageController;
    futureSearchText = getSearchBook();
    textList = bookGengerator(
      readScreen?.body != null ? readScreen?.body : encyclopediaBody?.body,
    )!;

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  Future<Data?> getSearchBook() async {
    return await searchBookProvider.fetchBook(
        type: searchData?.type, id: searchData?.id);
  }

  //Book data add
  List<String>? bookGengerator(String? x) {
    var textList = <String>[];

    print(x?.length);
    var indexCharacter;
    var cutCount = SizeConfig.screenWidth!.floor();

    if (x != null && x.length < cutCount) {
      cutCount = x.length;
      indexCharacter = x.indexOf(' ', cutCount);
    } else {
      indexCharacter = x?.indexOf(' ', cutCount);
    }

    var count = x != null ? (x.length / indexCharacter).floor() : 0;

    for (var i = 0; i < count; i++) {
      final a = x!.substring(0, indexCharacter);
      textList.add(a);

      x = x.substring(cutCount, x.length);
    }
    textList.add(x ?? '');
    return textList;
  }

  @override
  Widget build(BuildContext context) {
    inspect(textList.first);
    // print(SizeConfig.screenHeight);
    return searchData != null
        ? FutureBuilder<Data?>(
            future: futureSearchText,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                textList = bookGengerator(data?.body)!;
                inspect(data);
                return PageView(
                    controller: _pageController,
                    children: textList.map((e) {
                      print('EEEEEEEEEEEEE : ${e[0]}');
                      return BookPages(
                        listText: e,
                        readScreen: readScreen,
                        encyclopediaBody: encyclopediaBody,
                        controller: _pageController,
                        //   isVisiblty: isVisiblty,
                      );
                    }).toList());
              } else {
                return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                  color: Palette.main,
                )));
              }
            },
          )
        : PageView.builder(
            controller: _pageController,
            itemBuilder: (BuildContext context, index) {
              return BookPages(
                listText: textList[index],
                readScreen: readScreen,
                encyclopediaBody: encyclopediaBody,
                controller: _pageController, index: index,
                //   isVisiblty: isVisiblty,
              );
            },
          );
  }
}

class BookPages extends StatefulWidget {
  final Data? encyclopediaBody;
  final String listText;
  final Content? readScreen;
  final PageController? controller;
  final int? index;
  BookPages({
    Key? key,
    required this.listText,
    this.encyclopediaBody,
    this.readScreen,
    this.controller,
    this.index,
  }) : super(key: key);

  @override
  State<BookPages> createState() => _BookPagesState(
      listText: listText,
      readScreen: readScreen,
      encyclopediaBody: encyclopediaBody,
      controller: controller,
      index: index);
}

class _BookPagesState extends State<BookPages> {
  _BookPagesState({
    required this.listText,
    this.readScreen,
    this.encyclopediaBody,
    this.controller,
    this.index,
  });
  final PageController? controller;
  final Data? encyclopediaBody;
  final int? index;
  bool isBovandakMenu = false;
  bool isFavorite = false;
  bool isSettings = false;
  bool isShare = false;
  bool isVisiblty = false;
  bool isYoutubeActive = false;
  final String listText;
  final Content? readScreen;
  double selectedValue = 0;

  var items = 1;
  bool isDarkTheme = false;
  bool isLisghtTheme = false;
  bool isPhoneturnHorizontal = false;
  bool isPhoneturnVertical = false;
  double textSize = 16.0;
  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to set brightness';
    }
  }

  Widget hideMenuAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(children: [
          SizedBox(
              height: 20,
              width: 50,
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/images/arrow.svg',
                    width: 20,
                  ),
                ),
              )),
        ]),
        Spacer(),
        Container(
            child: InkWell(
          onTap: () => setState(() {
            isBovandakMenu = !isBovandakMenu;
            isFavorite = false;

            isSettings = false;
            isShare = false;
            isYoutubeActive = false;
            print("BovandakMenu :: $isBovandakMenu");
          }),
          child: SvgPicture.asset(
            'assets/images/bovandakutyun_menu.svg',
            color: isBovandakMenu ? Palette.whenTapedButton : null,
            width: 30,
          ),
        )),
        Spacer(),
        SizedBox(
          // height: 120,
          // width: 32,
          child: Stack(children: [
            SizedBox(
                height: 80,
                width: 50,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                        isBovandakMenu = false;
                        isSettings = false;
                        isShare = false;
                        isYoutubeActive = false;
                        print("Favorite :: $isFavorite");
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/images/favorite.svg',
                      width: 20,
                      color: isFavorite ? Palette.whenTapedButton : null,
                    ),
                  ),
                )),
          ]),
        ),
      ],
    );
  }

  Widget hideBottomBarMenu() {
    final mediaQuery = MediaQuery.of(context).size;
    final book = context.read<ContentProvider>().bookContents;
    final theme = context.read<ThemeNotifier>();

    return Stack(
      children: [
        Stack(
          children: [
            Container(
              color: theme.backgroundColor != null
                  ? theme.backgroundColor
                  : Palette.textLineOrBackGroundColor,
              child: Container(
                alignment: Alignment(0, -1),
                color: isBovandakMenu || isFavorite
                    ? Color.fromRGBO(31, 31, 31, 0.5)
                    : theme.backgroundColor != null
                        ? theme.backgroundColor
                        : Palette.textLineOrBackGroundColor,
                height: 181,
                width: double.infinity,
                child: Column(children: [
                  Expanded(
                      child: Column(
                    children: [
                      SizedBox(height: 15.0),
                      hideMenuAppBar(),
                      SizedBox(
                          width: 250,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '${book?.title}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          )),
                      SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                          width: 300,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Expanded(
                              child: Text(
                                '${book?.author}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    height: 1),
                              ),
                            ),
                          )),
                    ],
                  )),
                ]),
              ),
            ),
            isVisiblty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: Container(
                        color: book?.content != null && isBovandakMenu ||
                                isFavorite
                            ? theme.backgroundColor != null
                                ? theme.backgroundColor
                                : Color.fromRGBO(35, 35, 35, 0.5)
                            : theme.backgroundColor != null
                                ? theme.backgroundColor
                                : Palette.textLineOrBackGroundColor,
                        height: 80,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 3.0,
                                      color: isYoutubeActive ||
                                              isSettings ||
                                              isShare
                                          ? Colors.amber
                                          : theme.backgroundColor != null
                                              ? theme.backgroundColor
                                              : Palette
                                                  .textLineOrBackGroundColor,
                                    ))),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 77.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                        onTap: () => setState(() {
                                          isYoutubeActive = !isYoutubeActive;
                                          isSettings = false;
                                          isShare = false;
                                          isFavorite = false;
                                          isBovandakMenu = false;
                                        }),
                                        child: SvgPicture.asset(
                                          'assets/images/youtube.svg',
                                          color: isYoutubeActive
                                              ? Palette.whenTapedButton
                                              : null,
                                          fit: BoxFit.none,
                                        ),
                                      )),
                                      SizedBox(width: 80),
                                      Expanded(child: Text('11/365')),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isShare = !isShare;
                                            isYoutubeActive = false;
                                            isSettings = false;

                                            isFavorite = false;
                                            isBovandakMenu = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/share.svg',
                                          color: isShare
                                              ? Palette.whenTapedButton
                                              : null,
                                          fit: BoxFit.none,
                                        ),
                                      )),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSettings = !isSettings;
                                            isYoutubeActive = false;
                                            isShare = false;

                                            isFavorite = false;
                                            isBovandakMenu = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/settings.svg',
                                          color: isSettings
                                              ? Palette.whenTapedButton
                                              : null,
                                          fit: BoxFit.none,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            book?.content != null && isBovandakMenu
                ? Positioned(
                    top: 90,
                    child: Container(
                      color: Color.fromRGBO(31, 31, 31, 0.7),
                      height: mediaQuery.height,
                      width: mediaQuery.width,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: Palette.whenTapedButton,
                                  height: 3.0,
                                ),
                                Container(
                                    color: theme.backgroundColor != null
                                        ? theme.backgroundColor
                                        : Palette.textLineOrBackGroundColor,
                                    child: GlobalBovandakLists()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            isYoutubeActive ? youtubrShow() : Container(),
            isFavorite ? favoriteShow() : Container(),
            isSettings ? settingsShow() : Container(),
            isShare ? shareShow() : Container(),
          ],
        ),
      ],
    );
  }

  Widget youtubrShow() {
    final mediaQuery = MediaQuery.of(context).size;
    final theme = context.read<ThemeNotifier>();
    final orentation = MediaQuery.of(context).orientation;
    return Positioned(
      bottom: 80.0,
      child: Container(
          color: Color.fromRGBO(31, 31, 31, 0.5),
          width: mediaQuery.width,
          height: mediaQuery.height,
          child: Stack(children: [
            Positioned(
                top: orentation == Orientation.landscape
                    ? MediaQuery.of(context).size.height / 4
                    : mediaQuery.height / 1.55,
                width: mediaQuery.width,
                height: mediaQuery.height,
                child: Container(
                    color: theme.backgroundColor != null
                        ? theme.backgroundColor
                        : Palette.textLineOrBackGroundColor,
                    height: mediaQuery.height,
                    width: mediaQuery.width,
                    child: Column(children: [
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            height: orentation == Orientation.landscape
                                ? (mediaQuery.height / 1.95) - 30
                                : (mediaQuery.height / 1.95) - 80,
                            width: orentation == Orientation.landscape
                                ? 450
                                : mediaQuery.width,
                            child: YoutubePlayers(
                              url: readScreen?.videoLink,
                            )),
                      ),
                    ])))
          ])),
    );
  }

  Widget favoriteShow() {
    final mediaQuery = MediaQuery.of(context).size;
    final theme = context.read<ThemeNotifier>();
    final orentation = MediaQuery.of(context).orientation;

    return Positioned(
      top: 90,
      child: Container(
        color: Color.fromRGBO(31, 31, 31, 0.7),
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Palette.whenTapedButton,
                  height: 3.0,
                ),
                // SizedBox(height: 15.0),
                // Container(
                //   color: Palette.textLineOrBackGroundColor,
                //   child: Text(
                //     'Պահպանած էջեր',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //   ),
                // ),

                Container(
                  color: theme.backgroundColor != null
                      ? theme.backgroundColor
                      : Palette.textLineOrBackGroundColor,
                  child: Column(
                    children: [
                      SizedBox(height: 15.0),
                      Text(
                        'Պահպանած էջեր',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Text('$index'),
                                  title: Text('Data$index'),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),

                // Expanded(
                //   child: Container(
                //     color: theme.backgroundColor != null
                //         ? theme.backgroundColor
                //         : Palette.textLineOrBackGroundColor,
                //     height: orentation == Orientation.landscape
                //         ? mediaQuery.height / 1.55
                //         : mediaQuery.height,
                //     width: mediaQuery.width,
                //     child: Column(
                //       children: [
                //         SizedBox(height: 15.0),
                //         Text(
                //           'Պահպանած էջեր',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //               fontSize: 16, fontWeight: FontWeight.bold),
                //         ),
                //         ListView.builder(
                //             shrinkWrap: true,
                //             itemCount: 4,
                //             scrollDirection: Axis.vertical,
                //             itemBuilder: (context, index) {
                //               return Column(
                //                 children: [
                //                   ListTile(
                //                     leading: Text('$index'),
                //                     title: Text('Data$index'),
                //                   ),
                //                   Divider(
                //                     thickness: 1,
                //                   ),
                //                 ],
                //               );
                //             }),
                //         // Container(
                //         //   width: mediaQuery.width,
                //         //   height: mediaQuery.height - 120,
                //         //   child: ListView.builder(
                //         //       shrinkWrap: true,
                //         //       itemCount: 4,
                //         //       scrollDirection: Axis.vertical,
                //         //       itemBuilder: (context, index) {
                //         //         return Column(
                //         //           children: [
                //         //             ListTile(
                //         //               leading: Text('$index'),
                //         //               title: Text('Data$index'),
                //         //             ),
                //         //             Divider(
                //         //               thickness: 1,
                //         //             ),
                //         //           ],
                //         //         );
                //         //       }),
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget settingsShow() {
    final mediaQuery = MediaQuery.of(context).size;
    final theme = context.read<ThemeNotifier>();
    final orentation = MediaQuery.of(context).orientation;
    return Positioned(
        bottom: 80.0,
        top: 80.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          color: theme.backgroundColor != null
              ? theme.backgroundColor
              : Palette.textLineOrBackGroundColor,
          width: mediaQuery.width,
          height: mediaQuery.height,
          child: orentation == Orientation.landscape
              ? SingleChildScrollView(
                  child: Stack(children: [
                  Positioned(
                      child: Container(
                    width: mediaQuery.width,
                    height: mediaQuery.height,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Text(
                          'Կարգավորումներ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Divider(
                          color: Color.fromRGBO(226, 224, 224, 1),
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height - 250,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, //  mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Expanded(
                                            child: Text(
                                              'Պայծառություն',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1,
                                                color: Color.fromRGBO(
                                                    122, 108, 115, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 70,
                                            child: SliderTheme(
                                                data: SliderTheme.of(context)
                                                    .copyWith(
                                                  activeTrackColor:
                                                      Palette.main,
                                                  inactiveTrackColor:
                                                      Color.fromRGBO(
                                                          226, 224, 224, 1),
                                                  trackShape:
                                                      RoundedRectSliderTrackShape(),
                                                  trackHeight: 4.0,
                                                  thumbShape:
                                                      RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              12.0),
                                                  thumbColor: Palette.main,
                                                  overlayColor:
                                                      Palette.whenTapedButton,
                                                  overlayShape:
                                                      RoundSliderOverlayShape(
                                                          overlayRadius: 18.0),
                                                  tickMarkShape:
                                                      RoundSliderTickMarkShape(),
                                                  activeTickMarkColor:
                                                      Palette.main,
                                                  inactiveTickMarkColor:
                                                      Color.fromRGBO(
                                                          226, 224, 224, 1),
                                                  valueIndicatorShape:
                                                      PaddleSliderValueIndicatorShape(),
                                                  valueIndicatorColor:
                                                      Palette.main,
                                                  valueIndicatorTextStyle:
                                                      TextStyle(
                                                          color: Palette.main),
                                                ),
                                                child: FutureBuilder(
                                                    future: ScreenBrightness()
                                                        .current,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      double currentBrightness =
                                                          0;
                                                      if (snapshot.hasData) {
                                                        currentBrightness =
                                                            snapshot.data!;
                                                      }
                                                      return StreamBuilder<
                                                          double>(
                                                        stream: ScreenBrightness()
                                                            .onCurrentBrightnessChanged,
                                                        builder: (context,
                                                            snapshot) {
                                                          double
                                                              changedBrightness =
                                                              currentBrightness;
                                                          if (snapshot
                                                              .hasData) {
                                                            changedBrightness =
                                                                snapshot.data!;
                                                          }

                                                          return Slider
                                                              .adaptive(
                                                            value:
                                                                changedBrightness,
                                                            onChanged: (value) {
                                                              setBrightness(
                                                                  value);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    })),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Divider(
                                      color: Color.fromRGBO(226, 224, 224, 1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Տառաչափ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: orentation ==
                                                  Orientation.landscape
                                              ? 10.0
                                              : 20.0,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50.0,
                                            color: Colors.amber,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    //!!!!
                                                    if (textSize >= 12.0) {
                                                      setState(() {
                                                        textSize =
                                                            textSize - 2.0;
                                                      });
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/images/VectorLine.svg',
                                                  ),
                                                ),
                                                Text(
                                                  'Աա',
                                                  style: TextStyle(
                                                      fontSize: textSize),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (textSize <= 20.0) {
                                                      setState(() {
                                                        textSize =
                                                            textSize + 2.0;
                                                      });
                                                    }
                                                    print(
                                                        "aklsdfjasdlkfjadskkkkkkkk$textSize");
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 22.0),
                                                    child: SvgPicture.asset(
                                                        'assets/images/plusik.svg'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Divider(
                                      color: Color.fromRGBO(226, 224, 224, 1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Ռեժիմ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: orentation ==
                                                  Orientation.landscape
                                              ? 0.1
                                              : 10.0,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 85.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isLisghtTheme =
                                                            !isLisghtTheme;
                                                        isDarkTheme = false;
                                                        context
                                                            .read<
                                                                ThemeNotifier>()
                                                            .lightThemeData();
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 60,
                                                        height: 70,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                width: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          37,
                                                                      width: 37,
                                                                      color: !isLisghtTheme
                                                                          ? Color.fromRGBO(
                                                                              226,
                                                                              224,
                                                                              224,
                                                                              1)
                                                                          : Palette
                                                                              .whenTapedButton,
                                                                      child: Container(
                                                                          height:
                                                                              37,
                                                                          width:
                                                                              37,
                                                                          color: Color.fromRGBO(
                                                                              226,
                                                                              224,
                                                                              224,
                                                                              1)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.1
                                                                  : 10.0,
                                                            ),
                                                            Text(
                                                              'Ցերեկ',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    1,
                                                                color: !isLisghtTheme
                                                                    ? Color
                                                                        .fromRGBO(
                                                                            186,
                                                                            166,
                                                                            177,
                                                                            1)
                                                                    : Palette
                                                                        .whenTapedButton,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isDarkTheme =
                                                            !isDarkTheme;
                                                        isLisghtTheme = false;
                                                        context
                                                            .read<
                                                                ThemeNotifier>()
                                                            .darkThemeData();
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 60,
                                                        height: 70,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                width: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 37,
                                                                  height: 37,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.0
                                                                  : 10.0,
                                                            ),
                                                            Text(
                                                              'Գիշեր',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    1,
                                                                color: !isDarkTheme
                                                                    ? Color
                                                                        .fromRGBO(
                                                                            186,
                                                                            166,
                                                                            177,
                                                                            1)
                                                                    : Palette
                                                                        .whenTapedButton,
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
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Divider(
                                      color: Color.fromRGBO(226, 224, 224, 1),
                                      thickness: 1.2,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Էկրան',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: orentation ==
                                                  Orientation.landscape
                                              ? 0.1
                                              : 10.0,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 85.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isPhoneturnHorizontal =
                                                            !isPhoneturnHorizontal;
                                                        isPhoneturnVertical =
                                                            false;
                                                      });
                                                      SystemChrome
                                                          .setPreferredOrientations([
                                                        DeviceOrientation
                                                            .landscapeRight,
                                                        DeviceOrientation
                                                            .landscapeLeft,
                                                      ]);
                                                    },
                                                    child: Container(
                                                        width: 50,
                                                        height: double.infinity,
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/images/phone1.svg',
                                                              color: !isPhoneturnHorizontal
                                                                  ? null
                                                                  : Palette
                                                                      .whenTapedButton,
                                                            ),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.1
                                                                  : 15.0,
                                                            ),
                                                            Text(
                                                              'Հորիզոնական',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          186,
                                                                          166,
                                                                          177,
                                                                          1),
                                                                  fontFamily:
                                                                      "GHEAGrapalat",
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print('dark theme');
                                                      setState(() {
                                                        isPhoneturnVertical =
                                                            !isPhoneturnVertical;
                                                        isPhoneturnHorizontal =
                                                            false;
                                                        SystemChrome
                                                            .setPreferredOrientations([
                                                          DeviceOrientation
                                                              .portraitUp,
                                                          DeviceOrientation
                                                              .portraitDown,
                                                        ]);
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 50,
                                                        height: double.infinity,
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/images/phone2.svg',
                                                                height: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 19
                                                                    : null,
                                                                color: !isPhoneturnVertical
                                                                    ? null
                                                                    : Palette
                                                                        .whenTapedButton),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.1
                                                                  : 10.0,
                                                            ),
                                                            Text(
                                                              'Ուղղահայաց',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          186,
                                                                          166,
                                                                          177,
                                                                          1),
                                                                  fontFamily:
                                                                      "GHEAGrapalat",
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //!!!!
                                ])),
                      )
                    ]),
                  )),
                ]))
              : Stack(children: [
                  Positioned(
                      child: Container(
                    width: mediaQuery.width,
                    height: mediaQuery.height,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Text(
                          'Կարգավորումներ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Divider(
                          color: Color.fromRGBO(226, 224, 224, 1),
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height - 250,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, //  mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Expanded(
                                            child: Text(
                                              'Պայծառություն',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1,
                                                color: Color.fromRGBO(
                                                    122, 108, 115, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 70,
                                            child: SliderTheme(
                                                data: SliderTheme.of(context)
                                                    .copyWith(
                                                  activeTrackColor:
                                                      Palette.main,
                                                  inactiveTrackColor:
                                                      Color.fromRGBO(
                                                          226, 224, 224, 1),
                                                  trackShape:
                                                      RoundedRectSliderTrackShape(),
                                                  trackHeight: 4.0,
                                                  thumbShape:
                                                      RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              12.0),
                                                  thumbColor: Palette.main,
                                                  overlayColor:
                                                      Palette.whenTapedButton,
                                                  overlayShape:
                                                      RoundSliderOverlayShape(
                                                          overlayRadius: 18.0),
                                                  tickMarkShape:
                                                      RoundSliderTickMarkShape(),
                                                  activeTickMarkColor:
                                                      Palette.main,
                                                  inactiveTickMarkColor:
                                                      Color.fromRGBO(
                                                          226, 224, 224, 1),
                                                  valueIndicatorShape:
                                                      PaddleSliderValueIndicatorShape(),
                                                  valueIndicatorColor:
                                                      Palette.main,
                                                  valueIndicatorTextStyle:
                                                      TextStyle(
                                                          color: Palette.main),
                                                ),
                                                child: FutureBuilder(
                                                    future: ScreenBrightness()
                                                        .current,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      double currentBrightness =
                                                          0;
                                                      if (snapshot.hasData) {
                                                        currentBrightness =
                                                            snapshot.data!;
                                                      }
                                                      return StreamBuilder<
                                                          double>(
                                                        stream: ScreenBrightness()
                                                            .onCurrentBrightnessChanged,
                                                        builder: (context,
                                                            snapshot) {
                                                          double
                                                              changedBrightness =
                                                              currentBrightness;
                                                          if (snapshot
                                                              .hasData) {
                                                            changedBrightness =
                                                                snapshot.data!;
                                                          }

                                                          return Slider
                                                              .adaptive(
                                                            value:
                                                                changedBrightness,
                                                            onChanged: (value) {
                                                              setBrightness(
                                                                  value);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    })),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Divider(
                                      color: Color.fromRGBO(226, 224, 224, 1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Տառաչափ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: orentation ==
                                                  Orientation.landscape
                                              ? 10.0
                                              : 20.0,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (textSize >= 12.0) {
                                                      setState(() {
                                                        textSize =
                                                            textSize - 2.0;
                                                      });
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/images/VectorLine.svg',
                                                  ),
                                                ),
                                                Text(
                                                  'Աա',
                                                  style: TextStyle(
                                                      fontSize: textSize),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (textSize <= 20.0) {
                                                      setState(() {
                                                        textSize =
                                                            textSize + 2.0;
                                                      });
                                                    }
                                                    print(
                                                        "kolikolkioki$textSize");
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 22.0),
                                                    child: SvgPicture.asset(
                                                        'assets/images/plusik.svg'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Divider(
                                      color: Color.fromRGBO(226, 224, 224, 1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Ռեժիմ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: orentation ==
                                                  Orientation.landscape
                                              ? 0.1
                                              : 10.0,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 85.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isLisghtTheme =
                                                            !isLisghtTheme;
                                                        isDarkTheme = false;
                                                        context
                                                            .read<
                                                                ThemeNotifier>()
                                                            .lightThemeData();
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 60,
                                                        height: 70,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                width: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          37,
                                                                      width: 37,
                                                                      color: !isLisghtTheme
                                                                          ? Color.fromRGBO(
                                                                              226,
                                                                              224,
                                                                              224,
                                                                              1)
                                                                          : Palette
                                                                              .whenTapedButton,
                                                                      child: Container(
                                                                          height:
                                                                              37,
                                                                          width:
                                                                              37,
                                                                          color: Color.fromRGBO(
                                                                              226,
                                                                              224,
                                                                              224,
                                                                              1)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.1
                                                                  : 10.0,
                                                            ),
                                                            Text(
                                                              'Ցերեկ',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    1,
                                                                color: !isLisghtTheme
                                                                    ? Color
                                                                        .fromRGBO(
                                                                            186,
                                                                            166,
                                                                            177,
                                                                            1)
                                                                    : Palette
                                                                        .whenTapedButton,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isDarkTheme =
                                                            !isDarkTheme;
                                                        isLisghtTheme = false;
                                                        context
                                                            .read<
                                                                ThemeNotifier>()
                                                            .darkThemeData();
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 60,
                                                        height: 70,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                width: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 27.0
                                                                    : 37.0,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 37,
                                                                  height: 37,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.0
                                                                  : 10.0,
                                                            ),
                                                            Text(
                                                              'Գիշեր',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    1,
                                                                color: !isDarkTheme
                                                                    ? Color
                                                                        .fromRGBO(
                                                                            186,
                                                                            166,
                                                                            177,
                                                                            1)
                                                                    : Palette
                                                                        .whenTapedButton,
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
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Divider(
                                      color: Color.fromRGBO(226, 224, 224, 1),
                                      thickness: 1.2,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Էկրան',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                              color: Color.fromRGBO(
                                                  122, 108, 115, 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: orentation ==
                                                  Orientation.landscape
                                              ? 0.1
                                              : 10.0,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 85.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isPhoneturnHorizontal =
                                                            !isPhoneturnHorizontal;
                                                        isPhoneturnVertical =
                                                            false;
                                                      });
                                                      SystemChrome
                                                          .setPreferredOrientations([
                                                        DeviceOrientation
                                                            .landscapeRight,
                                                        DeviceOrientation
                                                            .landscapeLeft,
                                                      ]);
                                                    },
                                                    child: Container(
                                                        width: 50,
                                                        height: double.infinity,
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/images/phone1.svg',
                                                              color: !isPhoneturnHorizontal
                                                                  ? null
                                                                  : Palette
                                                                      .whenTapedButton,
                                                            ),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.1
                                                                  : 15.0,
                                                            ),
                                                            Text(
                                                              'Հորիզոնական',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          186,
                                                                          166,
                                                                          177,
                                                                          1),
                                                                  fontFamily:
                                                                      "GHEAGrapalat",
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print('dark theme');
                                                      setState(() {
                                                        isPhoneturnVertical =
                                                            !isPhoneturnVertical;
                                                        isPhoneturnHorizontal =
                                                            false;
                                                        SystemChrome
                                                            .setPreferredOrientations([
                                                          DeviceOrientation
                                                              .portraitUp,
                                                          DeviceOrientation
                                                              .portraitDown,
                                                        ]);
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 50,
                                                        height: double.infinity,
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/images/phone2.svg',
                                                                height: orentation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 19
                                                                    : null,
                                                                color: !isPhoneturnVertical
                                                                    ? null
                                                                    : Palette
                                                                        .whenTapedButton),
                                                            SizedBox(
                                                              height: orentation ==
                                                                      Orientation
                                                                          .landscape
                                                                  ? 0.1
                                                                  : 10.0,
                                                            ),
                                                            Text(
                                                              'Ուղղահայաց',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          186,
                                                                          166,
                                                                          177,
                                                                          1),
                                                                  fontFamily:
                                                                      "GHEAGrapalat",
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //!!!!
                                ])),
                      )
                    ]),
                  )),
                ]),
        ));
  }

  Widget shareShow() {
    final mediaQuery = MediaQuery.of(context).size;
    final orentation = MediaQuery.of(context).orientation;

    final theme = context.read<ThemeNotifier>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Container(
        color: Color.fromRGBO(31, 31, 31, 0.5),
        child: Stack(
          children: [
            Positioned(
              top: orentation == Orientation.landscape
                  ? MediaQuery.of(context).size.height / 3
                  : MediaQuery.of(context).size.height / 1.48,
              child: Container(
                color: theme.backgroundColor != null
                    ? theme.backgroundColor
                    : Palette.textLineOrBackGroundColor,
                height: mediaQuery.height,
                width: mediaQuery.width,
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          SizedBox(height: 15.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (
                                      context,
                                    ) =>
                                        SaveShowDialog(
                                          isShow: true,
                                        ));
                              },
                              child: Text(
                                'Կիսվել',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Divider(
                              color: Color.fromRGBO(226, 224, 224, 1),
                              thickness: 1,
                            ),
                          ),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/messenger 2.svg'),
                                  SvgPicture.asset(
                                      'assets/images/whatsapp 2.svg'),
                                  SvgPicture.asset('assets/images/gmail 2.svg'),
                                  SvgPicture.asset(
                                      'assets/images/messenger 2.svg'),
                                  SvgPicture.asset(
                                      'assets/images/vk-social-logotype (1) 2.svg'),
                                  SvgPicture.asset(
                                      'assets/images/facebook (1) 4.svg'),
                                  SvgPicture.asset(
                                      'assets/images/twitter (1) 4.svg'),
                                ],
                              )
                            ],
                          )),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.read<ThemeNotifier>();
    var theme = appTheme.theme != null ? appTheme.theme : appTheme.lightTheme;
    var pageIndex = context.read<ContentProvider>().pageIndex;

    return Theme(
      data: theme,
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                isVisiblty = !isVisiblty;
                isBovandakMenu = false;
              }),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: appTheme.readBookBackgroundColor != null
                    ? appTheme.readBookBackgroundColor
                    : Color.fromRGBO(226, 225, 224, 1),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          index == 0
                              ? Container(
                                  height: 238,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          bottom: 49,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 94,
                                                width: double.infinity,
                                                color: Color.fromRGBO(
                                                    164, 171, 189, 1),
                                              ))),
                                      Positioned.fill(
                                          child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                height: 180,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Palette
                                                      .textLineOrBackGroundColor,
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                        51, 51, 51, 1),
                                                    width: 01,
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                        child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        height: 164.0,
                                                        width: 122.0,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: encyclopediaBody !=
                                                                  null
                                                              ? '${encyclopediaBody?.image}'
                                                              : '${readScreen?.image}',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ))),
                                      encyclopediaBody != null
                                          ? Positioned.fill(
                                              child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20.0, right: 20.0),
                                                  color: Palette
                                                      .textLineOrBackGroundColor,
                                                  width: double.infinity,
                                                  height: 49,
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  true,
                                                              builder: (
                                                                context,
                                                              ) =>
                                                                  SaveShowDialog(
                                                                      isShow:
                                                                          false));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            //  const SizedBox(width: 16),
                                                            SvgPicture.asset(
                                                                'assets/images/այքըններ.svg'),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Text('Կիսվել')
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          print(
                                                              'share anel paterin');
                                                          // _showMyDialog();
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder: (
                                                                context,
                                                              ) =>
                                                                  SaveShowDialog(
                                                                    isShow:
                                                                        true,
                                                                  ));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/images/վելացնել1.svg'),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Text('Պահել'),
                                                            //const SizedBox(width: 16),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ))
                                          : Container(height: 0.1),
                                    ],
                                  ),
                                )
                              : Container(height: 0.1),
                          SizedBox(height: 16.0),
                          index == 0
                              ? Center(
                                  child: SizedBox(
                                      width: 235,
                                      height: 60,
                                      child: Text(
                                        encyclopediaBody != null
                                            ? '${encyclopediaBody?.title}'
                                            : '${readScreen?.title}',
                                        style: TextStyle(
                                            fontFamily: "GHEAGrapalat",
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1),
                                        textAlign: TextAlign.center,
                                      )))
                              : Container(
                                  height: 0.1,
                                  width: 0.1,
                                ),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text: '$listText',
                                style: TextStyle(
                                    color: Colors.black,
                                    height: 2.5,
                                    fontWeight: FontWeight.w200,
                                    fontSize: textSize,
                                    fontFamily: 'GHEAGrapalat',
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
            isVisiblty ? hideBottomBarMenu() : Container(),
          ],
        ),
      )

          // bottomNavigationBar:
          ),
    );
  }
}
