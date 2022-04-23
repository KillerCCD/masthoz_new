import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_read_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/audio_library/audio_librar_data_show.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '/config/palette.dart';

class AudioLibraryByCharacters extends StatefulWidget {
  const AudioLibraryByCharacters({
    Key? key,
    required this.characters,
    required this.characterByindex,
    required this.characterIndex,
  }) : super(key: key);

  final String characterByindex;
  final int characterIndex;
  final List<Object> characters;

  @override
  _AudioLibraryByCharactersState createState() =>
      _AudioLibraryByCharactersState(
        characters: characters,
        characterByindex: characterByindex,
        characterIndex: characterIndex,
      );
}

class _AudioLibraryByCharactersState extends State<AudioLibraryByCharacters>
    with SingleTickerProviderStateMixin {
  _AudioLibraryByCharactersState({
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
          SliverAppBar(
            title: ActionsHelper(
              //botomPadding: 55,
              text: '${characterByindex.toUpperCase()}',
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
  Future<List<ByCharacters>?>? audioLibraryByCharacters;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: wordsArm.length,
        vsync: this,
        initialIndex: characterIndex,
        animationDuration: Duration.zero);
    audioLibraryByCharacters = bookDataProvider
        .getDataByCharacters(Api.audioLibrariesByCharacters(characterByindex));

    super.initState();
  }

  Widget buildData() {
    return FutureBuilder<List<ByCharacters>?>(
        future: audioLibraryByCharacters,
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
                  return ListTile(
                    textColor: Color.fromRGBO(84, 112, 126, 1),
                    title: Text('${data?[index].title}'),
                    leading: Text(
                      '0${index}',
                      style: TextStyle(color: Palette.main),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AudioLibraryDataShow(
                                    dataCharacter: data?[index],
                                  )));
                    },
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
              setState(() {
                characters
                        .toString()
                        .toLowerCase()
                        .contains(wordsArm.elementAt(index))
                    ? audioLibraryByCharacters = bookDataProvider
                        .getDataByCharacters(Api.audioLibrariesByCharacters(
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
        body: TabBarView(
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
                .toList()),

        //     ))
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
