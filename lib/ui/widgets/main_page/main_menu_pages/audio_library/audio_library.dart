import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/book_channgeNotifire.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:provider/provider.dart';

import '../../../helper_widgets/menuShow.dart';

import 'audio_library_by_characters.dart';

class AudioLibrary extends StatefulWidget {
  const AudioLibrary({Key? key}) : super(key: key);

  @override
  _AudioLibraryState createState() => _AudioLibraryState();
}

class _AudioLibraryState extends State<AudioLibrary>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<BookNotifire>(
      context,
    ).resetDatas();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            // SliverAppBar(
            //   title: ActionsHelper(
            //     //botomPadding: 55,
            //     text: 'Ձայնադարան',
            //     fontFamily: 'GHEAGrapalat',
            //     rightPadding: 10.0,
            //     fontSize: 20,
            //     laterSpacing: 1,
            //     fontWeight: FontWeight.bold,
            //     color: Palette.appBarTitleColor,
            //   ),
            //   expandedHeight: 73,
            //   backgroundColor: Palette.textLineOrBackGroundColor,
            //   elevation: 0,
            //   automaticallyImplyLeading: false,
            //   systemOverlayStyle: SystemUiOverlayStyle(
            //       statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            // ),
            SliverAppBar(
              title: Text(
                'Ձայնադարան',
                style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1,
                    fontFamily: 'GHEAGrapalat',
                    fontWeight: FontWeight.w700,
                    color: Palette.appBarTitleColor),
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
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: Palette.textLineOrBackGroundColor,
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 43,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 130,
                          color: Color.fromRGBO(246, 246, 246, 1),
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 13, bottom: 13),
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Սեղմելով ցանկացած տառի վրա կարող եք ընթերցել այդ տառին համապատասխան նյութերը',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 180,
                      child: _ArmenianItalian(),
                    )
                  ],
                ),
              ),
            )
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
        .getDialect_Encyclopaedia_Characters(Api.audioLibrariesCharacters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>?>(
      future: charctersData,
      builder: (context, snapshot) {
        var characters = snapshot.data as List<String>;

        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Palette.textLineOrBackGroundColor,
            body: GridView.count(
              mainAxisSpacing: 30,
              crossAxisCount: 7,
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
                                    builder: (_) => AudioLibraryByCharacters(
                                          characters: characters,
                                          characterByindex: wordsArm[index],
                                          characterIndex: index,
                                        )));
                          }
                        : null,
                    child: Text(
                      '${wordsArm[index]}',
                      style: TextStyle(
                        fontFamily: 'ArshaluyseArtU',
                        fontSize: 20,
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
            child: Center(
                child: CircularProgressIndicator(
              color: Palette.main,
            )),
          );
        }
      },
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
  "օ",
  "ֆ"
];
