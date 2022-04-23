import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_page.dart';

import '../../../../domens/models/book_data/content_list.dart';

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

  bool isBovandakMenu = false;
  bool isFavorite = false;
  bool isSettings = false;
  bool isShare = false;
  bool isVisiblty = false;
  bool isYoutubeActive = false;
  final String listText;
  final Content? readScreen;
  final String? encyclopediaBody;
  Widget hideMenuAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
        Expanded(
          flex: 5,
          child: Container(
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
        ),
        Expanded(
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
      ],
    );
  }

  Widget hideBottomBarMenu() {
    final mediaQuery = MediaQuery.of(context).size;
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.0),
              color: isBovandakMenu || isFavorite
                  ? Color.fromRGBO(31, 31, 31, 0.5)
                  : Palette.textLineOrBackGroundColor,
              height: 181,
              width: double.infinity,
              child: Column(children: [
                SizedBox(height: 10.0),
                hideMenuAppBar(),
                SizedBox(
                    width: 200,
                    child: Text(
                      'Սբ. Թերեզա Հիսուս Մանկան (1873-1897)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromRGBO(25, 4, 18, 1),
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )),
                SizedBox(
                  height: 17.0,
                ),
                SizedBox(
                    width: 200,
                    child: Text(
                      'ԵՐԳԵԼ ՏԻՐՈՋ ՈՂՈՐՄՈՒԹՅՈՒՆԸ',
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
            isVisiblty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: isYoutubeActive || isSettings
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
                                child: SvgPicture.asset(
                                    'assets/images/share.svg')),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSettings = !isSettings;
                                  isYoutubeActive = false;
                                });
                              },
                              child: SvgPicture.asset(
                                'assets/images/settings.svg',
                                color:
                                    isSettings ? Palette.whenTapedButton : null,
                              ),
                            )),
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
                          GlobalBovandakLists(),
                        ],
                      ),
                    ),
                  )
                : Container(),
            isYoutubeActive ? youtubrShow() : Container(),
            isFavorite ? favoriteShow() : Container(),
            isSettings ? settingsShow() : Container(),
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
              top: mediaQuery.height / 4,
              child: Container(
                color: Palette.textLineOrBackGroundColor,
                height: mediaQuery.height,
                width: mediaQuery.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              'Կայքին օգնելու համար կարող եք դիտել / \n\nունկնդրել այս տեսանյութը։\n\nՇնորհակալություն կանխավ։',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 95.0),
                            Container(
                                color: Colors.red.shade500,
                                height: 250,
                                width: 400,
                                child: Center(child: Text('Youtube link'))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Palette.whenTapedButton,
                      height: 277.0,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Container(
        color: Color.fromRGBO(31, 31, 31, 0.5),
        child: Stack(
          children: [
            Positioned(
              top: mediaQuery.height / 9,
              child: Container(
                color: Palette.main,
                height: mediaQuery.height,
                width: mediaQuery.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              'Կայքին օգնելու համար կարող եք դիտել / \n\nունկնդրել այս տեսանյութը։\n\nՇնորհակալություն կանխավ։',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 95.0),
                            Container(
                                color: Colors.red.shade500,
                                height: 250,
                                width: 400,
                                child: Center(child: Text('Youtube link'))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Palette.whenTapedButton,
                      height: 170.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
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
                        text: TextSpan(
                          text: '$listText',
                          style: TextStyle(
                              color: Colors.black,
                              height: 1.8,
                              fontWeight: FontWeight.w200,
                              fontSize: 14,
                              fontFamily: 'GHEAGpalats',
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
