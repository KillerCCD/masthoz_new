import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';
import 'package:mashtoz_flutter/domens/models/user.dart';
import 'package:mashtoz_flutter/domens/models/user_sign_or_not.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/save_show_dialog.dart';
import 'package:mashtoz_flutter/ui/widgets/youtube_videos/youtuve_player.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final orentation = MediaQuery.of(context).orientation;
    var data = context.watch<UserInfoNotify>();
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20.0),
      child: Scaffold(
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
                          left: 25,
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
                      MenuShow(),
                    ],
                  )
                : SliverToBoxAdapter(),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => YoutubePlayers(
                                        lessons: lessons,
                                      )));
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: lessons!.image!,
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Flexible(
                        child: Text(
                          lessons!.title ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0,
                            fontFamily: 'GHEAGrapalat',
                            letterSpacing: 1,
                            color: Color.fromRGBO(84, 112, 126, 1),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Divider(),
                    orentation != Orientation.landscape
                        ? Container(
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
                                      'type': 'lessons',
                                      'type_id': lessons?.id,
                                      'customer_id': 38,
                                    };
                                    setState(() {
                                      userIsSign(data);
                                    });
                                    //  data.userData();
                                    // _showMyDialog();
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
      ),
    );
  }

  void userIsSign(Map<String, dynamic> data) async {
    User hasId = await userDataProvider.fetchUserInfo();
    bool isSign = await userDataProvider.saveFavorite(data);

    if (!isSign || hasId == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (
            context,
          ) =>
              SaveShowDialog(
                isShow: true,
              ));
    }
  }
}
