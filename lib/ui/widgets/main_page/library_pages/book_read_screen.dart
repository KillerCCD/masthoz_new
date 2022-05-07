import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/app_theme.dart/theme_notifire.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_page.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../../../domens/models/book_data/content_list.dart';
import '../../helper_widgets/save_show_dialog.dart';
import 'book_inherited_widget.dart';

class BookReadScreen extends StatefulWidget {
  const BookReadScreen({Key? key, this.readScreen, this.encyclopediaBody})
      : super(key: key);

  final String? encyclopediaBody;
  final Content? readScreen;

  @override
  State<BookReadScreen> createState() => _BookReadScreenState(
      readScreen: readScreen, encyclopediaBody: encyclopediaBody);
}

class _BookReadScreenState extends State<BookReadScreen> {
  _BookReadScreenState({this.readScreen, this.encyclopediaBody});

  var bookPartsLengt;
  var count = 0;
  var data;
  final String? encyclopediaBody;
  bool isVisiblty = false;
  final Content? readScreen;
  var textList = [];

  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _pageController;
    textList = bookGengerator(
        readScreen?.body != null ? readScreen?.body : encyclopediaBody)!;
    super.initState();
  }

  List<dynamic>? bookGengerator(String? x) {
    var textList = <dynamic>[];

    print(x?.length);
    var indexCharacter;
    var cutCount = 800;

    if (x!.length < cutCount) {
      cutCount = x.length;
      indexCharacter = x.indexOf(' ', cutCount);
    } else {
      indexCharacter = x.indexOf(' ', cutCount);
    }

    var count = (x.length / indexCharacter).floor();

    print(count);

    for (var i = 0; i < count; i++) {
      final a = x!.substring(0, indexCharacter);
      textList.add(a);

      x = x.substring(cutCount, x.length);
    }
    textList.add(x);
    return textList;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        onPageChanged: (index) {
          print("Page: ${index + 1}");
        },
        children: textList
            .map((e) => BookPages(
                  listText: e,
                  // readScreen: readScreen,
                  encyclopediaBody: encyclopediaBody,

                  //   isVisiblty: isVisiblty,
                ))
            .toList());
  }
}

class BookPages extends StatefulWidget {
  BookPages(
      {Key? key,
      required this.listText,
      this.encyclopediaBody,
      this.readScreen})
      : super(key: key);

  final String? encyclopediaBody;
  final String listText;
  final Content? readScreen;

  @override
  State<BookPages> createState() => _BookPagesState(
        listText: listText,
        readScreen: readScreen,
        encyclopediaBody: encyclopediaBody,
      );
}

class _BookPagesState extends State<BookPages> {
  _BookPagesState({
    required this.listText,
    this.readScreen,
    this.encyclopediaBody,
  });

  final String? encyclopediaBody;
  bool isBovandakMenu = false;
  bool isFavorite = false;
  bool isSettings = false;
  bool isShare = false;
  bool isVisiblty = false;
  bool isYoutubeActive = false;
  final String listText;
  final Content? readScreen;
  double selectedValue = 0;
  var textSize = <double>[14, 16, 18];
  var items = 1;
  double _brightness = 1.0;

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
    final books = context.read<ContentProvider>().bookContents;
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              color: Colors.white,
              child: Container(
                alignment: Alignment(0, -1),
                color: isBovandakMenu || isFavorite
                    ? Color.fromRGBO(31, 31, 31, 0.5)
                    : Palette.textLineOrBackGroundColor,
                height: 181,
                width: double.infinity,
                child: Column(children: [
                  SizedBox(height: 15.0),
                  hideMenuAppBar(),
                  SizedBox(
                      width: 250,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          '${books?.title}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromRGBO(25, 4, 18, 1),
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      )),
                  SizedBox(
                    height: 17.0,
                  ),
                  SizedBox(
                      width: 300,
                      child: Text(
                        '${books?.author}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromRGBO(25, 4, 18, 1),
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            height: 1),
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
                        color: isYoutubeActive || isSettings || isShare
                            ? Color.fromRGBO(31, 31, 31, 0.5)
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
                                          : Palette.textLineOrBackGroundColor,
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
            isBovandakMenu
                ? Positioned(
                    top: 90,
                    child: Container(
                      color: Palette.textLineOrBackGroundColor,
                      height: mediaQuery.height,
                      width: mediaQuery.width,
                      child: Column(
                        children: [
                          Container(
                            color: Palette.whenTapedButton,
                            height: 3.0,
                          ),
                          Expanded(child: GlobalBovandakLists()),
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
    return Positioned(
      bottom: 80.0,
      child: Container(
          color: Color.fromRGBO(31, 31, 31, 0.5),
          width: mediaQuery.width,
          height: mediaQuery.height,
          child: Stack(children: [
            Positioned(
                top: mediaQuery.height / 1.55,
                width: mediaQuery.width,
                height: mediaQuery.height,
                child: Container(
                    color: Palette.textLineOrBackGroundColor,
                    height: mediaQuery.height,
                    width: mediaQuery.width,
                    child: Column(children: [
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(30.0),
                            height: (mediaQuery.height / 1.95) - 80,
                            width: MediaQuery.of(context).size.width,
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
    return Positioned(
      top: 90,
      child: Container(
        color: Color.fromRGBO(31, 31, 31, 0.7),
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Stack(children: [
          Column(
            children: [
              Container(
                color: Palette.whenTapedButton,
                height: 3.0,
              ),
              Container(
                color: Palette.textLineOrBackGroundColor,
                height: mediaQuery.height / 2.10,
                width: mediaQuery.width,
                child: Column(
                  children: [
                    SizedBox(height: 15.0),
                    Text(
                      'Պահպանած էջեր',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: mediaQuery.width,
                      height: mediaQuery.height / 2.45,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 15,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: ElevatedButton(
            child: Text("Close Bottom Sheet"),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Widget settingsShow() {
    final mediaQuery = MediaQuery.of(context).size;

    return Positioned(
        bottom: 80.0,
        top: 80.0,
        left: 0.0,
        right: 0.0,
        child: Container(
            color: Colors.white,
            width: mediaQuery.width,
            height: mediaQuery.height,
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                                      child: Text(
                                        'Պայծառություն',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1,
                                          color:
                                              Color.fromRGBO(122, 108, 115, 1),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 70,
                                        child: SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              activeTrackColor: Palette.main,
                                              inactiveTrackColor:
                                                  Color.fromRGBO(
                                                      226, 224, 224, 1),
                                              trackShape:
                                                  RoundedRectSliderTrackShape(),
                                              trackHeight: 4.0,
                                              thumbShape: RoundSliderThumbShape(
                                                  enabledThumbRadius: 12.0),
                                              thumbColor: Palette.main,
                                              overlayColor:
                                                  Palette.whenTapedButton,
                                              overlayShape:
                                                  RoundSliderOverlayShape(
                                                      overlayRadius: 18.0),
                                              tickMarkShape:
                                                  RoundSliderTickMarkShape(),
                                              activeTickMarkColor: Palette.main,
                                              inactiveTickMarkColor:
                                                  Color.fromRGBO(
                                                      226, 224, 224, 1),
                                              valueIndicatorShape:
                                                  PaddleSliderValueIndicatorShape(),
                                              valueIndicatorColor: Palette.main,
                                              valueIndicatorTextStyle:
                                                  TextStyle(
                                                      color: Palette.main),
                                            ),
                                            child: FutureBuilder(
                                                future:
                                                    ScreenBrightness().current,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  double currentBrightness = 0;
                                                  if (snapshot.hasData) {
                                                    currentBrightness =
                                                        snapshot.data!;
                                                  }
                                                  return StreamBuilder<double>(
                                                    stream: ScreenBrightness()
                                                        .onCurrentBrightnessChanged,
                                                    builder:
                                                        (context, snapshot) {
                                                      double changedBrightness =
                                                          currentBrightness;
                                                      if (snapshot.hasData) {
                                                        changedBrightness =
                                                            snapshot.data!;
                                                      }

                                                      return Slider.adaptive(
                                                        value:
                                                            changedBrightness,
                                                        onChanged: (value) {
                                                          setBrightness(value);
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color:
                                              Color.fromRGBO(122, 108, 115, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                'assets/images/VectorLine.svg',
                                              ),
                                            ),
                                            Text(
                                              'Աա',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {});
                                                print(textSize);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color:
                                              Color.fromRGBO(122, 108, 115, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
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
                                                onTap: () {},
                                                child: Container(
                                                    width: 60,
                                                    height: 70,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            color:
                                                                Color.fromRGBO(
                                                                    226,
                                                                    224,
                                                                    224,
                                                                    1),
                                                            width: 47,
                                                            height: 47,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          'Ցերեկ',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    122,
                                                                    108,
                                                                    115,
                                                                    1),
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
                                                    context
                                                        .read<ThemeNotifier>()
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
                                                            color: Colors.black,
                                                            width: 47,
                                                            height: 47,
                                                            child: Text('cik2'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          'Գիշեր',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    122,
                                                                    108,
                                                                    115,
                                                                    1),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color:
                                              Color.fromRGBO(122, 108, 115, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
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
                                                  print('light theme');
                                                },
                                                child: Container(
                                                    width: 50,
                                                    height: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/images/phone1.svg'),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        Text('Հորիզոնական')
                                                      ],
                                                    )),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  print('dark theme');
                                                  setState(() {});
                                                },
                                                child: Container(
                                                    width: 50,
                                                    height: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/images/phone2.svg'),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text('Ուղղահայաց')
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
            ])));
  }

  Widget shareShow() {
    final mediaQuery = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Container(
        color: Color.fromRGBO(31, 31, 31, 0.5),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 1.48,
              child: Container(
                color: Palette.textLineOrBackGroundColor,
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
                                        SaveShowDialog());
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
    return Theme(
      data: theme,
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      isVisiblty = !isVisiblty;
                      isBovandakMenu = false;
                    }),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Expanded(
                            child: SingleChildScrollView(
                                child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: '$listText',
                            style: TextStyle(
                                color: Colors.black,
                                height: 2.5,
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
                                fontFamily: 'GHEAGrapalat',
                                letterSpacing: 1),
                          ),
                        ))),
                      ],
                    ),
                  ),
                ),
                isVisiblty ? hideBottomBarMenu() : Container(),
              ],
            ),
            color: Color.fromRGBO(226, 225, 224, 1)),
        // bottomNavigationBar:
      ),
    );
  }
}
