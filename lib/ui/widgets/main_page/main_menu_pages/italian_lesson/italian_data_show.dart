import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/data_providers/session_data_provider.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/save_show_dialog.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dictionary_screen/dictionary.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';

import '../../../helper_widgets/menuShow.dart';

class ItaliaLessonShow extends StatefulWidget {
  final Lessons? lessons;
  final bool? isShow;
  const ItaliaLessonShow({Key? key, this.lessons, this.isShow})
      : super(key: key);

  @override
  State<ItaliaLessonShow> createState() =>
      _ItaliaLessonShowState(lessons: lessons, isShow: isShow);
}

class _ItaliaLessonShowState extends State<ItaliaLessonShow> {
  final Lessons? lessons;
  final bool? isShow;
  _ItaliaLessonShowState({this.lessons, this.isShow});
  @override
  void initState() {
    super.initState();
  }

  final userDataProvider = UserDataProvider();
  Future<bool> checkUser() async {
    return await userDataProvider.check_user_Login();
  }

  @override
  Widget build(BuildContext context) {
    final orentation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Palette.textLineOrBackGroundColor,
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          orentation != Orientation.landscape
              ? SliverAppBar(
                  flexibleSpace: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 45,
                      ),
                      child: Text(
                        '${lessons?.number}',
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1,
                            fontFamily: 'GHEAGrapalat',
                            fontWeight: FontWeight.w700,
                            color: Palette.appBarTitleColor),
                      ),
                    ),
                  ),
                  floating: false,
                  pinned: true,
                  leading: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    width: 7,
                    height: 14,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      //iconSize: 13,
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Palette.appBarTitleColor,
                      ),
                      padding: EdgeInsets.only(right: double.infinity),
                      alignment: Alignment.center,
                    ),
                  ),
                  expandedHeight: 77,
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
                )
              : SliverToBoxAdapter(),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  YoutubePlayers(
                    lessons: lessons,
                    isShow: isShow,
                  ),
                  orentation != Orientation.landscape
                      ? Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          color: Palette.textLineOrBackGroundColor,
                          width: double.infinity,
                          height: 49,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  print('kisvel');
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (
                                        context,
                                      ) =>
                                          SaveShowDialog(
                                            isShow: false,
                                          ));
                                },
                                child: Row(
                                  children: [
                                    //  const SizedBox(width: 16),
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
                                    'type': 'armenian',
                                    'type_id': 6,
                                    'customer_id': 1,
                                  };
                                  userDataProvider.getFavorites();
                                  print('share anel paterin');
                                  // userDataProvider.saveFavorite(data);
                                  // _showMyDialog();
                                  // showDialog(
                                  //     context: context,
                                  //     barrierDismissible: false,
                                  //     builder: (
                                  //       context,
                                  //     ) =>
                                  //         SaveShowDialog(
                                  //           isShow: true,
                                  //         ));
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/վելացնել1.svg'),
                                    const SizedBox(width: 6),
                                    const Text('Պահել'),
                                    //const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      : SizedBox(
                          height: 0.1,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
