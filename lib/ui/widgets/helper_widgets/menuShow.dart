import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/data_providers/session_data_provider.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';
import 'package:mashtoz_flutter/domens/models/user.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/size_config.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/encyclopedia/encyclopedia.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/gallery/galery_item.dart';
import 'package:simple_shadow/simple_shadow.dart';
import '../../../domens/repository/book_data_provdier.dart';
import '../../../domens/repository/user_data_provider.dart';
import '../main_page/bottom_bars_pages/italian_lessons_screen/italian_lesson_page.dart';
import '../main_page/main_menu_pages/abaut_us.dart';
import '../main_page/main_menu_pages/audio_library/audio_library.dart';
import '../main_page/main_menu_pages/contact_page.dart';
import '../main_page/main_menu_pages/dialect/dialect.dart';

class MenuShow extends StatefulWidget {
  const MenuShow({Key? key}) : super(key: key);

  @override
  State<MenuShow> createState() => _MenuShowState();
}

class _MenuShowState extends State<MenuShow>
    with SingleTickerProviderStateMixin {
  final bookDataProvider = BookDataProvider();
  bool iconAcitve = true;
  Future<List<BookCategory>>? menuFuture;
  final sessionDataProvider = SessionDataProvider();
  int? custemerId;
  bool? isture;
  late AnimationController _controller;
  final userDataProvider = UserDataProvider();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    userDataProvider.fetchUserInfo().then((value) => custemerId = value.id);
    userIsSign();
    super.initState();
  }

  bool _isDrawerOpen() {
    return _controller.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _controller.status == AnimationStatus.forward;
  }

  void _toggleDrawer() {
    if (_controller.isCompleted) {
      _controller.reverse();
      setState(() {
        iconAcitve = true;
      });
    } else {
      _controller.forward();
      setState(() {
        iconAcitve = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0, end: 0.5 * pi).animate(_controller);
    final orintation = MediaQuery.of(context).orientation;
    return Container(
      height: double.infinity,
      width: 30,
      child: InkWell(
        onTap: () {
          print('dadasion');
          setState(() {
            _toggleDrawer();
            menuFuture = bookDataProvider.getCategoryLists(Api.menu);
          });
          showGeneralDialog(
              context: context,
              //     barrierDismissible: true,

              transitionDuration: Duration(microseconds: 500),
              barrierLabel: MaterialLocalizations.of(context).dialogLabel,
              pageBuilder: (
                context,
                _,
                __,
              ) {
                return Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 20.0),
                                    color: Palette.barColor,
                                    child: AppBar(
                                      leading: SizedBox(
                                        width: 0.1,
                                      ),
                                      systemOverlayStyle: SystemUiOverlayStyle(
                                          statusBarColor:
                                              Color.fromRGBO(25, 4, 18, 1)),
                                      elevation: 0.0,
                                      backgroundColor:
                                          Palette.barColor.withOpacity(0.5),
                                      flexibleSpace: Container(
                                        padding: EdgeInsets.only(
                                            right: 30.0, left: 43),
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: 20.0,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/mashtoz_org.svg',
                                              width: 250,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //toolbarHeight: 63,
                                      actions: [
                                        Container(
                                          width: 30,
                                          height: 51,
                                          child: InkWell(
                                            onTap: () {
                                              _toggleDrawer();
                                              Navigator.pop(context);
                                            },
                                            child: Stack(children: [
                                              Stack(
                                                children: [
                                                  SimpleShadow(
                                                    child: SvgPicture.asset(
                                                      'assets/images/app_bar_icon_button.svg',

                                                      color: iconAcitve
                                                          ? Palette
                                                              .appBarIconMenuColor
                                                          : const Color
                                                                  .fromRGBO(
                                                              122, 108, 115, 1),
                                                      fit: BoxFit.cover,

                                                      //width: 60,
                                                      //width: 22,
                                                    ),
                                                    opacity: 0.15,
                                                    offset: const Offset(0, 4),
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.15),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: AnimatedBuilder(
                                                    animation: animation,
                                                    builder: (context, child) {
                                                      return Transform.rotate(
                                                        angle: animation.value
                                                            .toDouble(),
                                                        child: _isDrawerOpen() ||
                                                                _isDrawerOpening()
                                                            ? SvgPicture.asset(
                                                                'assets/images/close_bar_icon.svg',
                                                                fit:
                                                                    BoxFit.none,
                                                              )
                                                            : SvgPicture.asset(
                                                                'assets/images/asset_bar_icon.svg',
                                                                fit:
                                                                    BoxFit.none,
                                                              ),
                                                      );
                                                    },
                                                  )),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: 120,
                        bottom: 60, //
                        child: Container(
                          //padding: EdgeInsets.only(bottom: 130),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(83, 66, 77, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(31, 31, 31, 1),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 5.0),
                                ),
                              ]),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    children: [
                                      //!!
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              //margin: EdgeInsets.only(right: 75),

                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  FutureBuilder<List<dynamic>?>(
                                                      future: menuFuture,
                                                      builder:
                                                          (context, snapshot) {
                                                        var data =
                                                            snapshot.data;

                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          50.0),
                                                              child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                strokeWidth:
                                                                    2.0,
                                                                color: Palette
                                                                    .main,
                                                              )));
                                                        } else if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          if (snapshot
                                                              .hasError) {
                                                            return const Text(
                                                                'Error');
                                                          } else if (snapshot
                                                              .hasData) {
                                                            return Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              70),
                                                                      height: SizeConfig
                                                                          .screenHeight,
                                                                      child: ListView.builder(
                                                                          scrollDirection: Axis.vertical,
                                                                          shrinkWrap: true,
                                                                          physics: AlwaysScrollableScrollPhysics(),
                                                                          itemCount: data?.length,
                                                                          itemBuilder: (contesxt, index) {
                                                                            return Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: GestureDetector(
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: 50.0,
                                                                                  child: Text(
                                                                                    '${data?[index].title}',
                                                                                    style: TextStyle(
                                                                                      decoration: TextDecoration.none,
                                                                                      color: Palette.textLineOrBackGroundColor,
                                                                                      fontFamily: 'GHEAGrapalat',
                                                                                      letterSpacing: 1,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontSize: 12.0,
                                                                                    ),
                                                                                    textAlign: TextAlign.end,
                                                                                  ),
                                                                                ),
                                                                                onTap: () {
                                                                                  switch (index) {
                                                                                    case 0:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();

                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (_) => Ecyclopedia(),
                                                                                        ),
                                                                                      );
                                                                                      break;
                                                                                    case 1:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (_) => ItalianPage()),
                                                                                      );
                                                                                      break;
                                                                                    case 2:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (_) => Dialect()),
                                                                                      );
                                                                                      break;
                                                                                    case 3:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (_) => GalleryItem()),
                                                                                      );
                                                                                      break;
                                                                                    case 4:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (_) => AudioLibrary()),
                                                                                      );
                                                                                      break;
                                                                                    case 5:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (_) => InfoPage(
                                                                                                    isShow: true,
                                                                                                  )));

                                                                                      break;
                                                                                    case 6:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (_) => InfoPage(
                                                                                                    isShow: false,
                                                                                                  )));
                                                                                      break;
                                                                                    case 7:
                                                                                      Navigator.pop(context);
                                                                                      _toggleDrawer();
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (_) => Contact()),
                                                                                      );
                                                                                      break;
                                                                                    default:
                                                                                  }
                                                                                  print('menu: $index');
                                                                                },
                                                                              ),
                                                                            );
                                                                          }),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      height:
                                                                          50,
                                                                      color: Colors
                                                                          .red,
                                                                      child: Text(
                                                                          'dadas')),
                                                                  SizedBox(
                                                                    height:
                                                                        15.0,
                                                                  ),
                                                                  isture!
                                                                      ? Align(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          child:
                                                                              Expanded(
                                                                            child:
                                                                                Container(
                                                                              margin: EdgeInsets.only(right: 70),
                                                                              height: 50,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      sessionDataProvider.deleteAllToken();
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        // padding:
                                                                                        //     EdgeInsets.only(left: 60.0),

                                                                                        SvgPicture.asset('assets/images/log_out.svg'),
                                                                                        SizedBox(width: 10.0),
                                                                                        Text(
                                                                                          'Դուրս գալ',
                                                                                          style: TextStyle(color: Color.fromRGBO(186, 166, 177, 1), fontFamily: 'GHEAGrapalat', letterSpacing: 1, fontWeight: FontWeight.w400, fontSize: 17.0),
                                                                                          textAlign: TextAlign.end,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              0.1),
                                                                ],
                                                              ),
                                                            );
                                                          } else {
                                                            return const Text(
                                                                'Empty data');
                                                          }
                                                        } else {
                                                          return Text(
                                                              'State: ${snapshot.connectionState}');
                                                        }
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],

                                    //   ],
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  ).drive(
                    Tween<Offset>(begin: Offset(0, -1.0), end: Offset.zero),
                  ),
                  child: child,
                );
              });
        },
        child: Stack(children: [
          Stack(
            children: [
              SimpleShadow(
                child: SvgPicture.asset(
                  'assets/images/app_bar_icon_button.svg',

                  color: iconAcitve
                      ? Palette.appBarIconMenuColor
                      : const Color.fromRGBO(122, 108, 115, 1),
                  fit: BoxFit.none,

                  //width: 60,
                  //width: 22,
                ),
                opacity: 0.15,
                offset: const Offset(0, 4),
                color: Color.fromRGBO(0, 0, 0, 0.15),
              ),
            ],
          ),
          Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: animation.value.toDouble(),
                    child: _isDrawerOpen() || _isDrawerOpening()
                        ? SvgPicture.asset(
                            'assets/images/close_bar_icon.svg',
                            fit: BoxFit.none,
                          )
                        : SvgPicture.asset(
                            'assets/images/asset_bar_icon.svg',
                            fit: BoxFit.none,
                          ),
                  );
                },
              )),
        ]),
      ),
    );
  }

  void userIsSign() async {
    Users hasId = await userDataProvider.fetchUserInfo();

    if (hasId != null) {
      isture = true;
    } else {
      isture = false;
    }
  }
}
