import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_page.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:provider/provider.dart';
import '../../../../domens/models/book_data/content_list.dart';
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
  double brightness = 0.0;
  // void changeTextSize(int index) {
  //   textSize.forEach(
  //     (element) {
  //       print(element.toInt())
  //     },
  //   );
  //   setState(() {});
  // }
  @override
  void initState() {
    initPlatformBrightness();
    super.initState();
  }

  Future<void> initPlatformBrightness() async {
    double bright;
    try {
      bright = await FlutterScreenWake.brightness;
    } on PlatformException {
      bright = 1.0;
    }
    if (!mounted) return;
    setState(() {
      brightness = bright;
    });
  }

  Widget hideMenuAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Stack(children: [
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
        ),
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: SizedBox(
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
          ),
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
                  SizedBox(height: 5.0),
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
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
                                        : null),
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
                                ),
                              )),
                            ],
                          ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Container(
        color: Color.fromRGBO(31, 31, 31, 0.5),
        child: Stack(
          children: [
            Positioned(
              top: mediaQuery.height / 3.5,
              child: Container(
                color: Palette.textLineOrBackGroundColor,
                height: mediaQuery.height,
                width: mediaQuery.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 230,
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // SizedBox(height: 20.0),
                            // RichText(
                            //   textAlign: TextAlign.center,
                            //   text: TextSpan(
                            //     children: <TextSpan>[
                            //       TextSpan(
                            //         text: 'Կայքին օգնելու համար կարող եք\n',
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.bold,
                            //             fontFamily: 'GHEAGrapalat',
                            //             color: Color.fromRGBO(97, 109, 135, 1)),
                            //       ),
                            //       TextSpan(
                            //         text: 'դիտել / ունկնդրել այս տեսանյութը։',
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.bold,
                            //             fontFamily: 'GHEAGrapalat',
                            //             color: Color.fromRGBO(97, 109, 135, 1)),
                            //       ),
                            //       TextSpan(
                            //         text: '\nՇնորհակալություն կանխավ։',
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.w400,
                            //             fontFamily: 'GHEAGrapalat',
                            //             color: Color.fromRGBO(97, 109, 135, 1)),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Text(
                            //   'Կայքին օգնելու համար կարող եք \nդիտել / ունկնդրել այս տեսանյութը։\nՇնորհակալություն կանխավ։',
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       fontFamily: 'GHEAGrapalat',
                            //       color: Color.fromRGBO(97, 109, 135, 1)),
                            //   textAlign: TextAlign.center,
                            // ),
                            SizedBox(height: 35.0),
                            Container(
                                height: 270,
                                child: YoutubePlayers(
                                  url: readScreen?.videoLink,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Palette.whenTapedButton,
                      height: 305.0,
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
                height: mediaQuery.height / 2,
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
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text('$index'),
                            title: Text('Data$index'),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget settingsShow() {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(125, 0, 78, 247),
      height: 700,
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Text(
              'Կարգավորումներ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
          Container(
              height: 525,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, //  mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Պայծառություն',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Color.fromRGBO(122, 108, 115, 1),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Slider.adaptive(
                            value: brightness,
                            min: 0,
                            max: 800.0,
                            onChanged: (newBrightnessValue) {
                              setState(() => brightness = newBrightnessValue);
                            },
                            activeColor: Palette.main,
                            thumbColor: Palette.main,
                            inactiveColor: Color.fromRGBO(226, 224, 224, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(
                      color: Color.fromRGBO(226, 224, 224, 1),
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, //   mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Տառաչափ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Color.fromRGBO(122, 108, 115, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  padding: const EdgeInsets.only(right: 22.0),
                                  child: SvgPicture.asset(
                                      'assets/images/plusik.svg'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(
                      color: Color.fromRGBO(226, 224, 224, 1),
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, //  mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Ռեժիմ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Color.fromRGBO(122, 108, 115, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 85.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('light theme');
                                },
                                child: Container(
                                    width: 50,
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          color:
                                              Color.fromRGBO(226, 224, 224, 1),
                                          width: 47,
                                          height: 47,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Ցերեկ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1,
                                            color: Color.fromRGBO(
                                                122, 108, 115, 1),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('dark theme');
                                  setState(() {});
                                },
                                child: Container(
                                    width: 50,
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          color: Colors.black,
                                          width: 47,
                                          height: 47,
                                          child: Text('cik2'),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Գիշեր',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1,
                                            color: Color.fromRGBO(
                                                122, 108, 115, 1),
                                          ),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(
                      color: Color.fromRGBO(226, 224, 224, 1),
                      thickness: 1.2,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      //   mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Էկրան',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Color.fromRGBO(122, 108, 115, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Container(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  print(textSize);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/phone1.svg'),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text('Հորիզոնական')
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  print(textSize);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/phone2.svg'),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text('Ուղղահայաց')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
    // Container(
    //   color: Colors.red,
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: Container(
    //           padding: EdgeInsets.only(right: 16.0, left: 16.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               SizedBox(height: 15.0),
    //               Padding(
    //                 padding:
    //                     const EdgeInsets.only(right: 20.0, left: 20.0),
    //                 child: Text(
    //                   'Կարգավորումներ',
    //                   style: TextStyle(
    //                       fontSize: 14, fontWeight: FontWeight.bold),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //               SizedBox(height: 10.0),
    //               Padding(
    //                 padding:
    //                     const EdgeInsets.only(right: 20.0, left: 20.0),
    //                 child: Divider(
    //                   color: Color.fromRGBO(226, 224, 224, 1),
    //                   thickness: 1,
    //                 ),
    //               ),
    //               Container(
    //                   height: 525,
    //                   width: 400,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Expanded(
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment
    //                               .start, //  mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             Padding(
    //                               padding:
    //                                   const EdgeInsets.only(left: 20.0),
    //                               child: Text(
    //                                 'Պայծառություն',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.w400,
    //                                   letterSpacing: 1,
    //                                   color: Color.fromRGBO(
    //                                       122, 108, 115, 1),
    //                                 ),
    //                               ),
    //                             ),
    //                             Container(
    //                               width:
    //                                   MediaQuery.of(context).size.width,
    //                               child: Slider.adaptive(
    //                                 value: brightness,
    //                                 min: 0,
    //                                 max: 800.0,
    //                                 onChanged: (newBrightnessValue) {
    //                                   setState(() => brightness =
    //                                       newBrightnessValue);
    //                                 },
    //                                 activeColor: Palette.main,
    //                                 thumbColor: Palette.main,
    //                                 inactiveColor:
    //                                     Color.fromRGBO(226, 224, 224, 1),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(
    //                             right: 20.0, left: 20.0),
    //                         child: Divider(
    //                           color: Color.fromRGBO(226, 224, 224, 1),
    //                           thickness: 1,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment
    //                               .start, //   mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             Padding(
    //                               padding:
    //                                   const EdgeInsets.only(left: 20.0),
    //                               child: Text(
    //                                 'Տառաչափ',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.w400,
    //                                   letterSpacing: 1,
    //                                   color: Color.fromRGBO(
    //                                       122, 108, 115, 1),
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: 20.0,
    //                             ),
    //                             Container(
    //                               height: 50.0,
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 children: [
    //                                   GestureDetector(
    //                                     onTap: () {},
    //                                     child: SvgPicture.asset(
    //                                       'assets/images/VectorLine.svg',
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     'Աա',
    //                                     style: TextStyle(fontSize: 16),
    //                                   ),
    //                                   GestureDetector(
    //                                     onTap: () {
    //                                       setState(() {});
    //                                       print(textSize);
    //                                     },
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.only(
    //                                           right: 22.0),
    //                                       child: SvgPicture.asset(
    //                                           'assets/images/plusik.svg'),
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(
    //                             right: 20.0, left: 20.0),
    //                         child: Divider(
    //                           color: Color.fromRGBO(226, 224, 224, 1),
    //                           thickness: 1,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment
    //                               .start, //  mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             Padding(
    //                               padding:
    //                                   const EdgeInsets.only(left: 20.0),
    //                               child: Text(
    //                                 'Ռեժիմ',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.w400,
    //                                   letterSpacing: 1,
    //                                   color: Color.fromRGBO(
    //                                       122, 108, 115, 1),
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: 10.0,
    //                             ),
    //                             Container(
    //                               height: 85.0,
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceAround,
    //                                 children: [
    //                                   GestureDetector(
    //                                     onTap: () {
    //                                       print('light theme');
    //                                     },
    //                                     child: Container(
    //                                         width: 50,
    //                                         height: double.infinity,
    //                                         child: Column(
    //                                           children: [
    //                                             Container(
    //                                               color: Color.fromRGBO(
    //                                                   226, 224, 224, 1),
    //                                               width: 47,
    //                                               height: 47,
    //                                             ),
    //                                             SizedBox(
    //                                               height: 10.0,
    //                                             ),
    //                                             Text(
    //                                               'Ցերեկ',
    //                                               style: TextStyle(
    //                                                 fontSize: 14,
    //                                                 fontWeight:
    //                                                     FontWeight.w400,
    //                                                 letterSpacing: 1,
    //                                                 color: Color.fromRGBO(
    //                                                     122, 108, 115, 1),
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         )),
    //                                   ),
    //                                   GestureDetector(
    //                                     onTap: () {
    //                                       print('dark theme');
    //                                       setState(() {});
    //                                     },
    //                                     child: Container(
    //                                         width: 50,
    //                                         height: double.infinity,
    //                                         child: Column(
    //                                           children: [
    //                                             Container(
    //                                               color: Colors.black,
    //                                               width: 47,
    //                                               height: 47,
    //                                               child: Text('cik2'),
    //                                             ),
    //                                             SizedBox(
    //                                               height: 10.0,
    //                                             ),
    //                                             Text(
    //                                               'Գիշեր',
    //                                               style: TextStyle(
    //                                                 fontSize: 14,
    //                                                 fontWeight:
    //                                                     FontWeight.w400,
    //                                                 letterSpacing: 1,
    //                                                 color: Color.fromRGBO(
    //                                                     122, 108, 115, 1),
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         )),
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(
    //                             right: 20.0, left: 20.0),
    //                         child: Divider(
    //                           color: Color.fromRGBO(226, 224, 224, 1),
    //                           thickness: 1.2,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Column(
    //                           //   mainAxisSize: MainAxisSize.min,
    //                           crossAxisAlignment:
    //                               CrossAxisAlignment.start,
    //                           children: [
    //                             Padding(
    //                               padding:
    //                                   const EdgeInsets.only(left: 20.0),
    //                               child: Text(
    //                                 'Էկրան',
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.w400,
    //                                   letterSpacing: 1,
    //                                   color: Color.fromRGBO(
    //                                       122, 108, 115, 1),
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(height: 12.0),
    //                             Container(
    //                               height: 80.0,
    //                               width:
    //                                   MediaQuery.of(context).size.width,
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceAround,
    //                                 children: [
    //                                   GestureDetector(
    //                                     onTap: () {
    //                                       setState(() {});
    //                                       print(textSize);
    //                                     },
    //                                     child: Column(
    //                                       children: [
    //                                         SvgPicture.asset(
    //                                             'assets/images/phone1.svg'),
    //                                         SizedBox(
    //                                           height: 15.0,
    //                                         ),
    //                                         Text('Հորիզոնական')
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   GestureDetector(
    //                                     onTap: () {
    //                                       setState(() {});
    //                                       print(textSize);
    //                                     },
    //                                     child: Column(
    //                                       children: [
    //                                         SvgPicture.asset(
    //                                             'assets/images/phone2.svg'),
    //                                         SizedBox(
    //                                           height: 10.0,
    //                                         ),
    //                                         Text('Ուղղահայաց')
    //                                       ],
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   )),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // Positioned(
    //   top: mediaQuery.height / 7.7,
    //   child: Container(
    //     color: Palette.textLineOrBackGroundColor,
    //     height: 250,
    //     width: 400,
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: Container(
    //             padding: EdgeInsets.only(right: 16.0, left: 16.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 SizedBox(height: 15.0),
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                       right: 20.0, left: 20.0),
    //                   child: Text(
    //                     'Կարգավորումներ',
    //                     style: TextStyle(
    //                         fontSize: 14, fontWeight: FontWeight.bold),
    //                     textAlign: TextAlign.center,
    //                   ),
    //                 ),
    //                 SizedBox(height: 10.0),
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                       right: 20.0, left: 20.0),
    //                   child: Divider(
    //                     color: Color.fromRGBO(226, 224, 224, 1),
    //                     thickness: 1,
    //                   ),
    //                 ),
    //                 Container(
    //                     height: 525,
    //                     width: 400,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment
    //                                 .start, //  mainAxisSize: MainAxisSize.min,
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 20.0),
    //                                 child: Text(
    //                                   'Պայծառություն',
    //                                   textAlign: TextAlign.start,
    //                                   style: TextStyle(
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w400,
    //                                     letterSpacing: 1,
    //                                     color: Color.fromRGBO(
    //                                         122, 108, 115, 1),
    //                                   ),
    //                                 ),
    //                               ),
    //                               Container(
    //                                 width: MediaQuery.of(context)
    //                                     .size
    //                                     .width,
    //                                 child: Slider.adaptive(
    //                                   value: brightness,
    //                                   min: 0,
    //                                   max: 800.0,
    //                                   onChanged: (newBrightnessValue) {
    //                                     setState(() => brightness =
    //                                         newBrightnessValue);
    //                                   },
    //                                   activeColor: Palette.main,
    //                                   thumbColor: Palette.main,
    //                                   inactiveColor: Color.fromRGBO(
    //                                       226, 224, 224, 1),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               right: 20.0, left: 20.0),
    //                           child: Divider(
    //                             color: Color.fromRGBO(226, 224, 224, 1),
    //                             thickness: 1,
    //                           ),
    //                         ),
    //                         Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment
    //                                 .start, //   mainAxisSize: MainAxisSize.min,
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 20.0),
    //                                 child: Text(
    //                                   'Տառաչափ',
    //                                   textAlign: TextAlign.start,
    //                                   style: TextStyle(
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w400,
    //                                     letterSpacing: 1,
    //                                     color: Color.fromRGBO(
    //                                         122, 108, 115, 1),
    //                                   ),
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 height: 20.0,
    //                               ),
    //                               Container(
    //                                 height: 50.0,
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceEvenly,
    //                                   children: [
    //                                     GestureDetector(
    //                                       onTap: () {},
    //                                       child: SvgPicture.asset(
    //                                         'assets/images/VectorLine.svg',
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       'Աա',
    //                                       style:
    //                                           TextStyle(fontSize: 16),
    //                                     ),
    //                                     GestureDetector(
    //                                       onTap: () {
    //                                         setState(() {});
    //                                         print(textSize);
    //                                       },
    //                                       child: Padding(
    //                                         padding:
    //                                             const EdgeInsets.only(
    //                                                 right: 22.0),
    //                                         child: SvgPicture.asset(
    //                                             'assets/images/plusik.svg'),
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               right: 20.0, left: 20.0),
    //                           child: Divider(
    //                             color: Color.fromRGBO(226, 224, 224, 1),
    //                             thickness: 1,
    //                           ),
    //                         ),
    //                         Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment
    //                                 .start, //  mainAxisSize: MainAxisSize.min,
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 20.0),
    //                                 child: Text(
    //                                   'Ռեժիմ',
    //                                   textAlign: TextAlign.start,
    //                                   style: TextStyle(
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w400,
    //                                     letterSpacing: 1,
    //                                     color: Color.fromRGBO(
    //                                         122, 108, 115, 1),
    //                                   ),
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 height: 10.0,
    //                               ),
    //                               Container(
    //                                 height: 85.0,
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceAround,
    //                                   children: [
    //                                     GestureDetector(
    //                                       onTap: () {
    //                                         print('light theme');
    //                                       },
    //                                       child: Container(
    //                                           width: 50,
    //                                           height: double.infinity,
    //                                           child: Column(
    //                                             children: [
    //                                               Container(
    //                                                 color:
    //                                                     Color.fromRGBO(
    //                                                         226,
    //                                                         224,
    //                                                         224,
    //                                                         1),
    //                                                 width: 47,
    //                                                 height: 47,
    //                                               ),
    //                                               SizedBox(
    //                                                 height: 10.0,
    //                                               ),
    //                                               Text(
    //                                                 'Ցերեկ',
    //                                                 style: TextStyle(
    //                                                   fontSize: 14,
    //                                                   fontWeight:
    //                                                       FontWeight
    //                                                           .w400,
    //                                                   letterSpacing: 1,
    //                                                   color: Color
    //                                                       .fromRGBO(
    //                                                           122,
    //                                                           108,
    //                                                           115,
    //                                                           1),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           )),
    //                                     ),
    //                                     GestureDetector(
    //                                       onTap: () {
    //                                         print('dark theme');
    //                                         setState(() {});
    //                                       },
    //                                       child: Container(
    //                                           width: 50,
    //                                           height: double.infinity,
    //                                           child: Column(
    //                                             children: [
    //                                               Container(
    //                                                 color: Colors.black,
    //                                                 width: 47,
    //                                                 height: 47,
    //                                                 child: Text('cik2'),
    //                                               ),
    //                                               SizedBox(
    //                                                 height: 10.0,
    //                                               ),
    //                                               Text(
    //                                                 'Գիշեր',
    //                                                 style: TextStyle(
    //                                                   fontSize: 14,
    //                                                   fontWeight:
    //                                                       FontWeight
    //                                                           .w400,
    //                                                   letterSpacing: 1,
    //                                                   color: Color
    //                                                       .fromRGBO(
    //                                                           122,
    //                                                           108,
    //                                                           115,
    //                                                           1),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           )),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               right: 20.0, left: 20.0),
    //                           child: Divider(
    //                             color: Color.fromRGBO(226, 224, 224, 1),
    //                             thickness: 1.2,
    //                           ),
    //                         ),
    //                         Expanded(
    //                           child: Column(
    //                             //   mainAxisSize: MainAxisSize.min,
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.start,
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 20.0),
    //                                 child: Text(
    //                                   'Էկրան',
    //                                   textAlign: TextAlign.start,
    //                                   style: TextStyle(
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w400,
    //                                     letterSpacing: 1,
    //                                     color: Color.fromRGBO(
    //                                         122, 108, 115, 1),
    //                                   ),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 12.0),
    //                               Container(
    //                                 height: 80.0,
    //                                 width: MediaQuery.of(context)
    //                                     .size
    //                                     .width,
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceAround,
    //                                   children: [
    //                                     GestureDetector(
    //                                       onTap: () {
    //                                         setState(() {});
    //                                         print(textSize);
    //                                       },
    //                                       child: Column(
    //                                         children: [
    //                                           SvgPicture.asset(
    //                                               'assets/images/phone1.svg'),
    //                                           SizedBox(
    //                                             height: 15.0,
    //                                           ),
    //                                           Text('Հորիզոնական')
    //                                         ],
    //                                       ),
    //                                     ),
    //                                     GestureDetector(
    //                                       onTap: () {
    //                                         setState(() {});
    //                                         print(textSize);
    //                                       },
    //                                       child: Column(
    //                                         children: [
    //                                           SvgPicture.asset(
    //                                               'assets/images/phone2.svg'),
    //                                           SizedBox(
    //                                             height: 10.0,
    //                                           ),
    //                                           Text('Ուղղահայաց')
    //                                         ],
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     )),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           color: Palette.whenTapedButton,
    //           height: 183.0,
    //         )
    //       ],
    //     ),
    //   ),
    // ),
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
              top: MediaQuery.of(context).size.height / 2,
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
                            child: Text(
                              'Կիսվել',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),
                              textAlign: TextAlign.center,
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
    return Scaffold(
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
    );
  }
}
