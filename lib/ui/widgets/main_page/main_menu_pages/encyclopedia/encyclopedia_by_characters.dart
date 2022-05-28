import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_read_screen.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../helper_widgets/menuShow.dart';
import '/config/palette.dart';

class EcyclopediaByCharacters extends StatefulWidget {
  const EcyclopediaByCharacters({
    Key? key,
    required this.characters,
    required this.characterByindex,
    required this.characterIndex,
  }) : super(key: key);

  final String characterByindex;
  final int characterIndex;
  final List<Object> characters;

  @override
  _EcyclopediaByCharactersState createState() => _EcyclopediaByCharactersState(
        characters: characters,
        characterByindex: characterByindex,
        characterIndex: characterIndex,
      );
}

class _EcyclopediaByCharactersState extends State<EcyclopediaByCharacters>
    with SingleTickerProviderStateMixin {
  _EcyclopediaByCharactersState({
    required this.characters,
    required this.characterByindex,
    required this.characterIndex,
  });

  final bookDataProvider = BookDataProvider();
  final String characterByindex;
  final int characterIndex;
  final List<Object> characters;
  Future<List<ByCharacters>?>? charctersData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          // SliverAppBar(
          //   title: ActionsHelper(
          //     //botomPadding: 55,
          //     text: 'Հանրագիտարան',
          //     fontFamily: 'GHEAGrapalat',
          //     rightPadding: 10.0,
          //     fontSize: 20,
          //     laterSpacing: 1,
          //     fontWeight: FontWeight.bold,
          //     color: Palette.appBarTitleColor,
          //     buttonShow: true,
          //   ),
          //   expandedHeight: 73,
          //   backgroundColor: Palette.textLineOrBackGroundColor,
          //   elevation: 0,
          //   automaticallyImplyLeading: false,
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //       statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
          // ),
          SliverAppBar(
            flexibleSpace: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                ),
                child: Container(
                  height: 73,
                  padding: EdgeInsets.only(top: 18),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    'Հանրագիտարան',
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                        fontFamily: 'GHEAGrapalat',
                        fontWeight: FontWeight.w700,
                        color: Palette.appBarTitleColor),
                  ),
                ),
              ),
            ),
            leading: SizedBox(
              width: 8,
              height: 14,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Palette.appBarTitleColor,
                ),
              ),
            ),
            expandedHeight: 73,
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
          // SliverAppBar(
          //   title: Text(
          //     'Հանրագիտարան',
          //     style: TextStyle(
          //         fontSize: 20,
          //         letterSpacing: 1,
          //         fontFamily: 'GHEAGrapalat',
          //         fontWeight: FontWeight.bold,
          //         color: Palette.appBarTitleColor),
          //   ),
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(
          //       Icons.arrow_back_ios_new_outlined,
          //       color: Palette.appBarTitleColor,
          //     ),
          //   ),
          //   expandedHeight: 73,
          //   backgroundColor: Palette.textLineOrBackGroundColor,
          //   elevation: 0,
          //   automaticallyImplyLeading: false,
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //       statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
          //   actions: [
          //     MenuShow(),
          //   ],
          // ),
          SliverFillRemaining(
            child: DelegateChild(
              characterByindex: characterByindex,
              characterIndex: characterIndex,
              characters: characters,
            ),
          )
        ]),
      ),
    );
  }
}

class DelegateChild extends StatefulWidget {
  DelegateChild({
    Key? key,
    required this.characterByindex,
    required this.characters,
    required this.characterIndex,
  }) : super(key: key);

  final String characterByindex;
  final int characterIndex;
  final Object characters;

  @override
  State<DelegateChild> createState() => _DelegateChildState(
        characterByindex: characterByindex,
        characters: characters,
        characterIndex: characterIndex,
      );
}

class _DelegateChildState extends State<DelegateChild>
    with SingleTickerProviderStateMixin {
  _DelegateChildState({
    required this.characterByindex,
    required this.characters,
    required this.characterIndex,
  });

  final bookDataProvider = BookDataProvider();
  final String characterByindex;
  final int characterIndex;
  final Object characters;
  Future<List<ByCharacters>?>? encyclopediaByCharacters;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: wordsArm.length,
        vsync: this,
        initialIndex: characterIndex,
        animationDuration: Duration.zero);
    encyclopediaByCharacters = bookDataProvider
        .getDataByCharacters(Api.encyclopediasByCharacters(characterByindex));

    super.initState();
  }

  Widget buildData() {
    return FutureBuilder<List<ByCharacters>?>(
        future: encyclopediaByCharacters,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                child: Center(
                    child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Palette.main,
            )));
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  // return ListTile(
                  //   textColor: Color.fromRGBO(84, 112, 126, 1),
                  //   title: Text('${data?[index].title}'),
                  //   leading: Text(
                  //     '0${index}',
                  //     style: TextStyle(color: Palette.main),
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (_) => BookReadScreen(
                  //                   encyclopediaBody: data?[index].body,
                  //                 )));
                  //   },
                  // );
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BookReadScreen(
                                    encyclopediaBody: data?[index],
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20.0, left: 22.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Text(
                                    '0${index + 1}',
                                    style: TextStyle(
                                      color: Palette.main,
                                      fontFamily: 'GHEAGrapalat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 260,
                                    child: Text(
                                      '${data?[index].title}',
                                      style: TextStyle(
                                          fontFamily: 'GHEAGrapalat',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromRGBO(113, 141, 156, 1)),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Color.fromRGBO(226, 224, 224, 1),
                          )
                        ],
                      ),
                    ),
                  );
                  // return ExpansionTile(
                  //   title: Text('${data?[index].title}'),
                  //   controlAffinity: ListTileControlAffinity.leading,
                  //   leading: SvgPicture.asset('assets/images/line24.svg'),
                  //   children: [
                  //     ListTile(
                  //       title: Text('${data?[index].body}'),
                  //     )
                  //   ],
                  // );
                },
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: characterIndex,
        length: wordsArm.length,
        child: Scaffold(
            backgroundColor: Palette.textLineOrBackGroundColor,
            appBar: PreferredSize(
                preferredSize: Size(18.0, 50.0),
                child: Container(
                    color: Color.fromRGBO(246, 246, 246, 1),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: TabBar(
                          indicatorWeight: 2,
                          unselectedLabelColor:
                              const Color.fromRGBO(122, 108, 115, 1),
                          labelColor: const Color.fromRGBO(251, 196, 102, 1),
                          indicatorColor: Colors.amber,
                          indicator: MaterialIndicator(
                            color: Colors.amber,
                            height: 2,
                            topLeftRadius: 0,
                            topRightRadius: 0,
                            bottomLeftRadius: 5,
                            bottomRightRadius: 5,
                            tabPosition: TabPosition.top,
                            paintingStyle: PaintingStyle.fill,
                          ),
                          controller: _tabController,
                          isScrollable: true,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          onTap: (index) {
                            setState(() {
                              characters
                                      .toString()
                                      .toLowerCase()
                                      .contains(wordsArm.elementAt(index))
                                  ? encyclopediaByCharacters =
                                      bookDataProvider.getDataByCharacters(
                                          Api.encyclopediasByCharacters(
                                              wordsArm.elementAt(index)))
                                  : null;
                            });
                          },
                          tabs: wordsArm.map((tabName) {
                            return Tab(
                              child: Text(
                                tabName,
                                style: TextStyle(
                                  fontFamily: 'ArshaluyseArtU',
                                  fontSize: 23,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  color: characters
                                          .toString()
                                          .toLowerCase()
                                          .contains(tabName.toLowerCase())
                                      ? null
                                      : Color.fromRGBO(186, 166, 177, 1),
                                ),
                              ),
                            );
                          }).toList()),
                    ))),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: wordsArm
                    .map(
                      (e) => characters
                              .toString()
                              .toLowerCase()
                              .contains(e.toLowerCase())
                          ? buildData()
                          : Container(
                              child: Center(
                                child: Text('Empty data'),
                              ),
                            ),
                    )
                    .toList())));
  }
}

List<String> wordsArm = [
  'ա',
  "բ",
  "գ",
  "դ",
  "ե",
  "զ",
  "է",
  "ը",
  "թ",
  "ժ",
  "ի",
  "լ",
  "խ",
  "ծ",
  "կ",
  "հ",
  "ձ",
  "ղ",
  "ճ",
  "մ",
  "յ",
  "ն",
  "շ",
  "ո",
  "չ",
  "պ",
  "ջ",
  "ռ",
  "ս",
  "վ",
  "տ",
  "ր",
  "ց",
  "ու",
  "փ",
  "ք",
  "ԵՎ",
  "Օ",
  "Ֆ"
];
