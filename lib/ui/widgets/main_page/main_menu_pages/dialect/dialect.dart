import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/actions_widgets.dart';

import 'diaelct_by_characters.dart';

class Dialect extends StatefulWidget {
  const Dialect({Key? key}) : super(key: key);

  @override
  _DialectState createState() => _DialectState();
}

class _DialectState extends State<Dialect> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: ActionsHelper(
                //botomPadding: 55,
                text: 'Համաբարբառ',
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
              child: Column(
                children: [
                  Container(
                    color: Color.fromRGBO(246, 246, 246, 1),
                    width: double.infinity,
                    height: 80,
                    child: Text(
                      'Սեղմելով ցանկացած տառի վրա կարող եք\n ընթերցել այդ տառին համապատասխան\n նյութերը',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 50),
                  Expanded(child: _ArmenianItalian()),
                ],
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
        .getDialect_Encyclopaedia_Characters(Api.dialectCharacters);
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
                                      builder: (_) => DialectByCharacters(
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
