import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mashtoz_flutter/config/palette.dart';

import '../buttons/bottom_navigation_bar/bottom_app_bar.dart';

import 'bottom_bars_pages/bottom_bar_menu_pages.dart';

enum BottomIcons { home, library, search, italian, account, initall }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomIcons icons = BottomIcons.initall;
  bool isAccount = false;
  bool isHome = false;
  bool isItalian = false;
  bool isLibrary = false;
  bool isSearch = false;
  final pages = [
    HomePage(),
    LibraryPage(),
    SearchPage(),
    ItalianPage(),
    AccountPage(),
  ];

  int _currentIndex = 0;

  tirgleColor() {
    return icons == BottomIcons.library
        ? Palette.libraryBacgroundColor
        : false || icons == BottomIcons.home
            ? Palette.textLineOrBackGroundColor
            : false || icons == BottomIcons.search
                ? Palette.searchBackGroundColor
                : false || icons == BottomIcons.italian
                    ? Palette.textLineOrBackGroundColor
                    : false || icons == BottomIcons.account
                        ? Palette.textLineOrBackGroundColor
                        : null;
  }

  SizedBox buildMyNavBar(BuildContext context) {
    return SizedBox(
      height: 80,
      // padding: const EdgeInsets.only(top: 14),
      child: Stack(
        children: [
          Container(
            color: tirgleColor(),
            width: double.infinity,
            height: 20,
            // color: Colors.black,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icons == BottomIcons.home
                    ? Expanded(
                        child: CustomPaint(
                          size: const Size(42, 22),
                          painter: Triangle(),
                        ),
                      )
                    : Expanded(child: Container()),
                icons == BottomIcons.library
                    ? Expanded(
                        child: CustomPaint(
                          size: const Size(42, 22),
                          painter: Triangle(),
                        ),
                      )
                    : Expanded(child: Container()),
                icons == BottomIcons.search
                    ? Expanded(
                        child: CustomPaint(
                          size: const Size(42, 22),
                          painter: Triangle(),
                        ),
                      )
                    : Expanded(child: Container()),
                icons == BottomIcons.italian
                    ? Expanded(
                        child: CustomPaint(
                          size: const Size(42, 22),
                          painter: Triangle(),
                        ),
                      )
                    : Expanded(child: Container()),
                icons == BottomIcons.account
                    ? Expanded(
                        child: CustomPaint(
                          size: const Size(42, 22),
                          painter: Triangle(),
                        ),
                      )
                    : Expanded(child: Container()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox.expand(
                    child: Container(
                      height: 55,
                      color: const Color.fromRGBO(83, 66, 77, 1),
                      child: Row(
                        children: [
                          // const SizedBox(width: 22.0),
                          Expanded(
                            child: BottomBar(
                              onPressed: () {
                                print('home');
                                setState(() {
                                  _currentIndex = 0;
                                  icons = BottomIcons.home;
                                  isHome = true;
                                  isLibrary = false;
                                  isSearch = false;
                                  isItalian = false;
                                  isAccount = false;
                                });
                              },
                              bottomIcons:
                                  icons == BottomIcons.home ? true : false,
                              path: SvgPicture.asset(
                                'assets/images/home.svg',
                                color: isHome ? Palette.cursor : null,
                                width: 25,
                                height: 30,
                              ),
                            ),
                          ),
                          //  const SizedBox(width: 45.0),
                          Expanded(
                            child: BottomBar(
                              onPressed: () {
                                print('library');
                                setState(() {
                                  icons = BottomIcons.library;
                                  _currentIndex = 1;
                                  isLibrary = true;
                                  isHome = false;
                                  isSearch = false;
                                  isItalian = false;
                                  isAccount = false;
                                });
                              },
                              bottomIcons:
                                  icons == BottomIcons.library ? true : false,
                              path: SvgPicture.asset(
                                'assets/images/library.svg',
                                color: isLibrary ? Palette.cursor : null,
                                width: 25,
                                height: 30,
                              ),
                            ),
                          ),
                          //const SizedBox(width: 45.0),
                          Expanded(
                            child: BottomBar(
                                onPressed: () {
                                  print('search');
                                  setState(() {
                                    _currentIndex = 2;
                                    icons = BottomIcons.search;
                                    isSearch = true;
                                    isHome = false;
                                    isLibrary = false;
                                    isItalian = false;
                                    isAccount = false;
                                  });
                                },
                                bottomIcons:
                                    icons == BottomIcons.search ? true : false,
                                path: SvgPicture.asset(
                                  'assets/images/search.svg',
                                  color: isSearch ? Palette.cursor : null,
                                  width: 25,
                                  height: 27,
                                )),
                          ),
                          // const SizedBox(width: 45.0),
                          Expanded(
                            child: BottomBar(
                              onPressed: () {
                                print('italian');
                                setState(() {
                                  icons = BottomIcons.italian;
                                  _currentIndex = 3;
                                  isItalian = true;
                                  isHome = false;
                                  isLibrary = false;
                                  isSearch = false;
                                  isAccount = false;
                                });
                              },
                              bottomIcons:
                                  icons == BottomIcons.italian ? true : false,
                              path: SvgPicture.asset(
                                'assets/images/italian_lessons.svg',
                                color: isItalian ? Palette.cursor : null,
                                width: 25,
                                height: 30,
                              ),
                            ),
                          ),
                          // const SizedBox(width: 40.0),
                          Expanded(
                            child: BottomBar(
                              onPressed: () {
                                print('account');
                                setState(() {
                                  _currentIndex = 4;
                                  icons = BottomIcons.account;
                                  isAccount = true;
                                  isHome = false;
                                  isLibrary = false;
                                  isSearch = false;
                                  isItalian = false;
                                });
                              },
                              bottomIcons:
                                  icons == BottomIcons.account ? true : false,
                              path: SvgPicture.asset(
                                'assets/images/profile.svg',
                                color: isAccount ? Palette.cursor : null,
                                width: 25,
                                height: 27,
                              ),
                            ),
                          ),
                          //const SizedBox(width: 40.0),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.textLineOrBackGroundColor,
        body: pages[_currentIndex],
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: buildMyNavBar(context));
  }
}
