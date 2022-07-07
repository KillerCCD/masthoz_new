import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/book_channgeNotifire.dart';
import 'package:mashtoz_flutter/domens/models/bottom_bar_color_notifire.dart';
import 'package:mashtoz_flutter/tab_navigator.dart';
import 'package:provider/provider.dart';

import '../buttons/bottom_navigation_bar/bottom_app_bar.dart';

import '../notifications/notification_service.dart';
import 'bottom_bars_pages/bottom_bar_menu_pages.dart';

enum BottomIcons {
  home,
  library,
  search,
  italian,
  account,
  initall,
}
enum ScreenName {
  books,
  book,
  bookRead,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  BottomIcons icons = BottomIcons.initall;
  bool isAccount = false;
  bool isHome = false;
  bool isItalian = false;
  bool isLibrary = false;
  bool isSearch = false;
  List<String> pageKeys = [
    'homepage',
    'librarypage',
    'searchpage',
    "italianpage",
    'accountpage'
  ];

  ScreenName secrenName = ScreenName.book;

  var _currentIndex = 0;
  String _currentPage = "homepage";
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "homepage": GlobalKey<NavigatorState>(),
    "librarypage": GlobalKey<NavigatorState>(),
    "searchpage": GlobalKey<NavigatorState>(),
    "italianpage": GlobalKey<NavigatorState>(),
    "accountpage": GlobalKey<NavigatorState>(),
  };

  NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    NotificationService.initialize(context);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      NotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
    
    super.initState();
  }

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

  Widget buildMyNavBar(
    BuildContext context,
  ) {
    final color =
        Provider.of<BottomColorNotifire>(context, listen: true).barColor;
    return SizedBox(
      height: 80,
      // padding: const EdgeInsets.only(top: 14),
      child: Stack(
        children: [
          Container(
            color: color,
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
                            child: Align(
                              alignment: Alignment.center,
                              child: BottomBar(
                                onPressed: () {
                                  // print('home');
                                  setState(() {
                                    // onItemTaped(0);
                                    context
                                        .read<BottomColorNotifire>()
                                        .setColor(
                                            Palette.textLineOrBackGroundColor);
                                    _selectTab(pageKeys[0], 0);
                                    setState(() {
                                      icons = BottomIcons.home;
                                    });
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
                          ),
                          //  const SizedBox(width: 45.0),
                          Expanded(
                            child: BottomBar(
                              onPressed: () {
                                //  print('library');
                                setState(() {
                                  icons = BottomIcons.library;
                                  // onItemTaped(1);
                                  context
                                      .read<BottomColorNotifire>()
                                      .setColor(Palette.libraryBacgroundColor);
                                  _selectTab(pageKeys[1], 1);
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
                                  // print('search');

                                  //onItemTaped(2);
                                  context
                                      .read<BottomColorNotifire>()
                                      .setColor(Palette.searchBackGroundColor);
                                  _selectTab(pageKeys[2], 2);
                                  icons = BottomIcons.search;
                                  isSearch = true;
                                  isHome = false;
                                  isLibrary = false;
                                  isItalian = false;
                                  isAccount = false;
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
                                //    print('italian');
                                context.read<BottomColorNotifire>().setColor(
                                    Palette.textLineOrBackGroundColor);
                                setState(() {
                                  icons = BottomIcons.italian;
                                  // _currentIndex = 3;
                                  _selectTab(pageKeys[3], 3);
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
                                //    print('account');
                                setState(() {
                                  //    onItemTaped(4);
                                  context.read<BottomColorNotifire>().setColor(
                                      Palette.textLineOrBackGroundColor);
                                  _selectTab(pageKeys[4], 4);
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

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentIndex) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _currentIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    print(tabItem);
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "homepage") {
            _selectTab("homepage", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          backgroundColor: Palette.textLineOrBackGroundColor,
          body: Stack(
            children: [
              _buildOffstageNavigator(
                  _navigatorKeys.keys.elementAt(_currentIndex)),
            ],
          ),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: buildMyNavBar(context)),
    );
  }
}
