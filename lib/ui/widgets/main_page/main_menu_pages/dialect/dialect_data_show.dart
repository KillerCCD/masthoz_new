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

class DialectDataShow extends StatefulWidget {
  final ByCharacters? dataCharacter;
  const DialectDataShow({Key? key, this.dataCharacter}) : super(key: key);

  @override
  State<DialectDataShow> createState() =>
      _DialectDataShowState(dataCharacter: dataCharacter);
}

class _DialectDataShowState extends State<DialectDataShow> {
  var textData =
      '135, 112. 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15. 16. 17. 18. 19. 20. 21. 22. 23. 24. 25. 26';

  final ByCharacters? dataCharacter;
  _DialectDataShowState({this.dataCharacter});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            expandedHeight: 73,
            backgroundColor: Palette.textLineOrBackGroundColor,
            pinned: false,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            flexibleSpace: ActionsHelper(
              leftPadding: 12,
              // botomPadding: 0,
              // topPadding: 30,
              text: '${dataCharacter?.title}',

              fontFamily: 'Grapalat',
              fontSize: 20,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.appBarTitleColor,
              buttonShow: true,
            ),
          ),

          //!Համաբարբառ
          SliverToBoxAdapter(
            child: ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: ((context, index) => SizedBox(height: 30.0)),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Expanded(
                  // width: 300,
                  // height: 300,
                  //fit: BoxFit.fitHeight,
                  child: Container(
                    color: index % 2 != 0
                        ? Color.fromRGBO(202, 217, 228, 1)
                        : Color.fromRGBO(197, 202, 212, 1),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          // constraints: BoxConstraints.expand(),
                          color: index % 2 != 0
                              ? Color.fromRGBO(172, 197, 215, 1)
                              : Color.fromRGBO(164, 171, 189, 1),
                          height: 44,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [Text('Երեմիա')],
                          ),
                        ),
                        ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(12.0),
                                child: IntrinsicHeight(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Wrap(children: [
                                        Text(
                                          textData,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                        ),
                                      ]),
                                    ),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                            color: Colors.red,
                                            child: Text(
                                              '${dataCharacter?.body}',
                                              textAlign: TextAlign.start,
                                            )),
                                      ),
                                    ),
                                  ],
                                )),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 20.0),
                            itemCount: 1),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
