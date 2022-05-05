import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            flexibleSpace: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 45,
                ),
                child: Text(
                  '0${lessons?.number}',
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                      fontFamily: 'GHEAGrapalat',
                      fontWeight: FontWeight.w700,
                      color: Palette.appBarTitleColor),
                ),
              ),
            ),
            pinned: false,
            floating: true,
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
          ),
          SliverToBoxAdapter(
            child: YoutubePlayers(
              lessons: lessons,
              isShow: isShow,
            ),
          ),
        ],
      ),
    );
  }
}
