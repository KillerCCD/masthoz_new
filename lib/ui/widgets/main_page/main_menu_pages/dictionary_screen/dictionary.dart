import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dictionary_screen/aarm_italy_dictionary.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: ActionsHelper(
                //botomPadding: 55,
                text: 'Բառարան',
                fontFamily: 'Grapalat',
                rightPadding: 10.0,
                fontSize: 20,
                laterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Palette.appBarTitleColor,
              ),
              expandedHeight: 73,
              backgroundColor: Palette.textLineOrBackGroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    toolbarHeight: 11,
                    backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
                    bottom: TabBar(
                      indicatorWeight: 2,
                      unselectedLabelColor:
                          const Color.fromRGBO(122, 108, 115, 1),
                      labelColor: const Color.fromRGBO(251, 196, 102, 1),
                      indicatorColor: Colors.amber,
                      controller: _controller,
                      tabs: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Tab(
                            child: Text(
                              'Հայերեն-\nԻտալերեն',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Tab(
                            child: Text(
                              'Իտալերեն-\nՀայերեն',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    controller: _controller,
                    children: const <Widget>[
                      _ArmenianItalian(),
                      _ItalianArmenian(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Armenian alphabet Widget
class _ArmenianItalian extends StatefulWidget {
  const _ArmenianItalian({Key? key}) : super(key: key);

  @override
  State<_ArmenianItalian> createState() => _ArmenianItalianState();
}

class _ArmenianItalianState extends State<_ArmenianItalian> {
  Future<List<String>?>? charctersData;
  final bookDataProvider = BookDataProvider();
  @override
  void initState() {
    charctersData = bookDataProvider
        .getDialect_Encyclopaedia_Characters(Api.armenianDictionaryCharacters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<String>?>(
        future: charctersData,
        builder: (context, snapshot) {
          var characters = snapshot.data as List<String>;

          if (snapshot.hasData) {
            return Scaffold(
              body: GridView.count(
                mainAxisSpacing: 30,
                crossAxisCount: 7,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(wordsArm.length, (index) {
                  return Center(
                    child: InkWell(
                      onTap: characters
                              .toString()
                              .toLowerCase()
                              .contains(wordsArm[index])
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DictionaryArmItl(
                                            characters: characters,
                                            characterByindex: wordsArm[index],
                                            characterIndex: index,
                                            isShow: true,
                                          )));
                            }
                          : null,
                      child: Text(
                        '${wordsArm[index]}',
                        style: TextStyle(
                          fontFamily: 'ArshaluyseArtU',
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: characters
                                  .toString()
                                  .toLowerCase()
                                  .contains(wordsArm[index])
                              ? null
                              : Color.fromRGBO(186, 166, 177, 1),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

//Italian alphabet Widget
class _ItalianArmenian extends StatefulWidget {
  const _ItalianArmenian({Key? key}) : super(key: key);

  @override
  State<_ItalianArmenian> createState() => _ItalianArmenianState();
}

class _ItalianArmenianState extends State<_ItalianArmenian> {
  Future<List<String>?>? charctersData;
  final bookDataProvider = BookDataProvider();
  @override
  void initState() {
    charctersData = bookDataProvider
        .getDialect_Encyclopaedia_Characters(Api.italianDictionaryCharacters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<String>?>(
        future: charctersData,
        builder: (context, snapshot) {
          var characters = snapshot.data as List<String>;

          if (snapshot.hasData) {
            return Scaffold(
              body: GridView.count(
                mainAxisSpacing: 30,
                crossAxisCount: 7,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(wordsIt.length, (index) {
                  return Center(
                    child: InkWell(
                      onTap: characters
                              .toString()
                              .toLowerCase()
                              .contains(wordsIt[index])
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DictionaryArmItl(
                                            characters: characters,
                                            characterByindex: wordsIt[index],
                                            characterIndex: index,
                                            isShow: false,
                                          )));
                            }
                          : null,
                      child: Text(
                        '${wordsIt[index]}',
                        style: TextStyle(
                          fontFamily: 'ArshaluyseArtU',
                          fontSize: 35,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: characters
                                  .toString()
                                  .toLowerCase()
                                  .contains(wordsIt[index].toLowerCase())
                              ? null
                              : Color.fromRGBO(186, 166, 177, 1),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          } else {
            return Container(
                child: Center(
                    child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Palette.main,
            )));
          }
        },
      ),
    );
  }
}

//Armenian alphabet
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
//English alphabet
List<String> wordsIt = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  ''
      'v',
  'w',
  'x',
  'y',
  'z',
];
