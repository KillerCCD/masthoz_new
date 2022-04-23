import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '/config/palette.dart';

class DictionaryArmItl extends StatefulWidget {
  const DictionaryArmItl({
    Key? key,
    required this.characters,
    required this.characterByindex,
    required this.characterIndex,
    required this.isShow,
  }) : super(key: key);

  final String characterByindex;
  final int characterIndex;
  final List<Object> characters;
  final bool isShow;

  @override
  _DictionaryArmItlState createState() => _DictionaryArmItlState(
      characters: characters,
      characterByindex: characterByindex,
      characterIndex: characterIndex,
      isShow: isShow);
}

class _DictionaryArmItlState extends State<DictionaryArmItl>
    with SingleTickerProviderStateMixin {
  _DictionaryArmItlState(
      {required this.characters,
      required this.characterByindex,
      required this.characterIndex,
      required this.isShow});

  final bookDataProvider = BookDataProvider();
  final String characterByindex;
  final int characterIndex;
  final List<Object> characters;
  Future<List<ByCharacters>?>? charctersData;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            title: ActionsHelper(
              //botomPadding: 55,
              text: isShow ? 'Հայերեն-իտալերեն' : 'Իտալերեն- Հայերեն',
              fontFamily: 'Grapalat',
              rightPadding: 10.0,
              fontSize: 20,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.appBarTitleColor,
              buttonShow: true,
            ),
            expandedHeight: 73,
            backgroundColor: Palette.textLineOrBackGroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
          ),
          SliverFillRemaining(
            child: DelegateChild(
              characterByindex: characterByindex,
              characterIndex: characterIndex,
              characters: characters,
              isShow: isShow,
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
    required this.isShow,
  }) : super(key: key);

  final String characterByindex;
  final int characterIndex;
  final Object characters;
  final bool isShow;

  @override
  State<DelegateChild> createState() => _DelegateChildState(
      characterByindex: characterByindex,
      characters: characters,
      characterIndex: characterIndex,
      isShow: isShow);
}

class _DelegateChildState extends State<DelegateChild>
    with SingleTickerProviderStateMixin {
  _DelegateChildState({
    required this.characterByindex,
    required this.characters,
    required this.characterIndex,
    required this.isShow,
  });

  final bookDataProvider = BookDataProvider();
  final String characterByindex;
  final int characterIndex;
  final Object characters;
  Future<List<ByCharacters>?>? charctersDataArmenian;
  Future<List<ByCharacters>?>? charctersDataItalian;
  final bool isShow;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: isShow ? wordsArm.length : wordsIt.length,
        vsync: this,
        initialIndex: characterIndex,
        animationDuration: Duration.zero);
    isShow
        ? charctersDataArmenian = bookDataProvider.getDataByCharacters(
            Api.armenianDictionaryByCharacters(characterByindex))
        : charctersDataItalian = bookDataProvider.getDataByCharacters(
            Api.italianDictionaryByCharacters(characterByindex));
    super.initState();
  }

  Widget buildData() {
    return FutureBuilder<List<ByCharacters>?>(
        future: isShow ? charctersDataArmenian : charctersDataItalian,
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
                  return ExpansionTile(
                    title: Text('${data?[index].title}'),
                    controlAffinity: ListTileControlAffinity.leading,
                    leading: SvgPicture.asset('assets/images/line24.svg'),
                    children: [
                      ListTile(
                        title: Text('${data?[index].body}'),
                      )
                    ],
                  );
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
      length: isShow ? wordsArm.length : wordsIt.length,
      child: Scaffold(
        appBar: TabBar(
          indicatorWeight: 2,
          unselectedLabelColor: const Color.fromRGBO(122, 108, 115, 1),
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
          labelPadding: const EdgeInsets.symmetric(horizontal: 15),
          onTap: (index) {
            print(wordsIt.elementAt(index).toLowerCase());
            setState(() {
              isShow
                  ? characters
                          .toString()
                          .toLowerCase()
                          .contains(wordsArm.elementAt(index))
                      ? charctersDataArmenian =
                          bookDataProvider.getDataByCharacters(
                              Api.armenianDictionaryByCharacters(
                                  wordsArm.elementAt(index)))
                      : null
                  : characters
                          .toString()
                          .toLowerCase()
                          .contains(wordsIt.elementAt(index).toLowerCase())
                      ? charctersDataItalian =
                          bookDataProvider
                              .getDataByCharacters(
                                  Api.italianDictionaryByCharacters(
                                      wordsIt.elementAt(index).toLowerCase()))
                      : null;
            });
          },
          tabs: isShow
              ? wordsArm.map((tabName) {
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
                }).toList()
              : wordsIt.map((tabName) {
                  return Tab(
                    child: Text(
                      tabName,
                      style: TextStyle(
                        fontFamily: 'ArshaluyseArtU',
                        fontSize: 35,
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
                }).toList(),
        ),
        body: TabBarView(
          controller: _tabController,
          children: isShow
              ? wordsArm
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
                  .toList()
              : wordsIt
                  .map(
                    (e) => characters
                            .toString()
                            .toLowerCase()
                            .contains(e.toLowerCase())
                        ? buildData()
                        : Container(
                            child: Center(
                                child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Palette.main,
                          ))),
                  )
                  .toList(),
        ),

        //     ))
      ),
    );
  }
}

class ItalianArmenian extends StatelessWidget {
  const ItalianArmenian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: GridView.count(
          mainAxisSpacing: 30,
          crossAxisCount: 7,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(wordsIt.length, (index) {
            return Center(
              child: InkWell(
                onTap: () {
                  print('hi');
                },
                child: Text(
                  '${wordsIt[index]}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rye(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
        ),
      ),
    );
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
List<String> wordsIt = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  '',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
