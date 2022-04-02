import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'dart:math' as math;
import '../../../../../config/palette.dart';
import '../../../helper_widgets/actions_widgets.dart';

class DictionaryArmItl extends StatefulWidget {
  const DictionaryArmItl({Key? key}) : super(key: key);

  @override
  _DictionaryArmItlState createState() => _DictionaryArmItlState();
}

class _DictionaryArmItlState extends State<DictionaryArmItl>
    with SingleTickerProviderStateMixin {
  //late TabController _controller;

  @override
  void initState() {
    // _controller = TabController(length: 10, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      const SliverAppBar(
        pinned: false,
        expandedHeight: 73,
        backgroundColor: Palette.textLineOrBackGroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
        flexibleSpace: ActionsHelper(
          buttonShow: true,
          leftPadding: 50,
          // botomPadding: 0,
          // topPadding: 30,
          text: 'Կապ',
          fontFamily: 'Grapalat',
          fontSize: 20,
          laterSpacing: 1,
          fontWeight: FontWeight.bold,
          color: Palette.appBarTitleColor,
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: Delegate(),
      ),

      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('grid item $index'),
            );
          },
          childCount: 50,
        ),
      )
      // SliverFillRemaining(
      //   child: DefaultTabController(
      //     length: wordsArm.length,
      //     child: Scaffold(
      //       body: Container(
      //         width: double.infinity,
      //         height: 50,
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: Material(
      //                 child: TabBar(
      //                     indicatorWeight: 2,
      //                     unselectedLabelColor:
      //                         const Color.fromRGBO(122, 108, 115, 1),
      //                     labelColor: const Color.fromRGBO(251, 196, 102, 1),
      //                     indicatorColor: Colors.amber,
      //                     indicator: MaterialIndicator(
      //                       height: 5,
      //                       topLeftRadius: 0,
      //                       topRightRadius: 0,
      //                       bottomLeftRadius: 5,
      //                       bottomRightRadius: 5,
      //                       tabPosition: TabPosition.top,
      //                     ),
      //                     //  controller: _controller,
      //                     isScrollable: true,
      //                     labelPadding:
      //                         const EdgeInsets.symmetric(horizontal: 20),
      //                     tabs: wordsArm
      //                         .map((tabName) => Tab(
      //                               child: Text(
      //                                 tabName,
      //                                 style: const TextStyle(
      //                                     fontFamily: 'ArshaluyseArtU',
      //                                     fontSize: 20,
      //                                     fontStyle: FontStyle.normal,
      //                                     fontWeight: FontWeight.bold),
      //                               ),
      //                             ))
      //                         .toList()),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // TabBarView(
      //       //   children: wordsArm
      //       //       .map((e) => ExpansionTile(
      //       //             textColor: Color.fromRGBO(251, 196, 102, 1),
      //       //             leading: Padding(
      //       //               padding: const EdgeInsets.only(top: 12),
      //       //               child:
      //       //                   SvgPicture.asset('assets/images/vector.svg'),
      //       //             ),
      //       //             title: const Text(
      //       //               "Արարիչ",
      //       //               style: TextStyle(
      //       //                   fontSize: 16, fontWeight: FontWeight.bold),
      //       //             ),
      //       //             initiallyExpanded: false,
      //       //             children: const [
      //       //               ListTile(
      //       //                 tileColor: Color.fromRGBO(246, 246, 246, 1),
      //       //                 title: Text(
      //       //                     '1. Տեղափոխել ավելի վար, իջեցնել. abbassare il quadro – նկարը ներքև իջեցնել; abbassare la lampada – կանթեղը վար իջեցնել; ցածրացնել, ավելի ցածր մակարդակի բերել. abbassare il muro della casa – ցածրացնել տան պատը; abbassare l’altezza della finestra – ցածրացնել պատուհանի բարձրությունը; ավելի ցածր տոնայնության, աստիճանի, ուժգնության բերել, մեղմացնել, նվազեցնել. abbassare la voce (o il tono della voce) – ձայնը (կամ ձայնի տոնայնությունը) իջեցնել, մեղմել; abbassare la radio – ռա'),
      //       //               ),
      //       //             ],
      //       //           ))
      //       //       .toList(),
      //       // ),
      //     ),
      //   ),
      // ),
    ]));
  }
}

class ArmenianItalian extends StatelessWidget {
  const ArmenianItalian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: GridView.count(
          mainAxisSpacing: 30,
          crossAxisCount: 7,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(wordsArm.length, (index) {
            return Center(
              child: InkWell(
                onTap: () {
                  print('hi');
                },
                child: Text(
                  '${wordsArm[index]}',
                  style: const TextStyle(
                      fontFamily: 'ArshaluyseArtU',
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

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DefaultTabController(
        length: wordsArm.length,
        child: Scaffold(
            body: Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
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
                            ),
                            //  controller: _controller,
                            isScrollable: true,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            tabs: wordsArm
                                .map((tabName) => Tab(
                                      child: Text(
                                        tabName,
                                        style: const TextStyle(
                                            fontFamily: 'ArshaluyseArtU',
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),
                  ],
                ))));
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
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
