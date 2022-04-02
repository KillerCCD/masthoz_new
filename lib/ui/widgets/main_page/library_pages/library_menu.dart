import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/text_widgets.dart';

import '../../helper_widgets/actions_widgets.dart';
import 'books_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool isColorAvtive = false;
  final libraryPages = const [
    TextHelper(
      text: 'Աղոթք',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      //color: Palette.textLineOrBackGroundColor
      index: 0,
    ),
    TextHelper(
      text: 'Ջատագովություն',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 1,
    ),
    TextHelper(
      text: 'Աստվածաշնչյան Նյութեր',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 3,
    ),
    TextHelper(
      text: 'Քրիստոնեական Ուսուցում',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 4,
    ),
    TextHelper(
        text: 'Մարեմական Նյութեր',
        fontSize: 18,
        fontFamily: 'Grapalat',
        fontWeight: FontWeight.w400,
        laterSpacing: 1,
        color: Palette.textLineOrBackGroundColor),
    TextHelper(
      text: 'Հայրախոսական Մատենաշար',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 5,
    ),
    TextHelper(
      text: 'Վարք Սրբոց',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 6,
    ),
    TextHelper(
      text: 'Հոգեշահ Հեղինակներ',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 7,
    ),
    TextHelper(
      text: 'Հոգեշահ Հեղինակներ',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 8,
    ),
    TextHelper(
      text: 'Ընդհանրական Եկեղեցու\nՎավերագրեր',
      fontSize: 18,
      textAlign: TextAlign.right,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 9,
    ),
    TextHelper(
        text: 'Հոգեբանություն',
        fontSize: 18,
        fontFamily: 'Grapalat',
        fontWeight: FontWeight.w400,
        laterSpacing: 1,
        color: Palette.textLineOrBackGroundColor),
    TextHelper(
      text: 'Աղանդներ',
      fontSize: 18,
      fontFamily: 'Grapalat',
      fontWeight: FontWeight.w400,
      laterSpacing: 1,
      color: Palette.textLineOrBackGroundColor,
      index: 10,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.libraryBacgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(25, 4, 18, 1),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Palette.barColor,
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(),
            child: ActionsHelper(
              leftPadding: 20,
              topPadding: 30,
              text: 'Գարադարան',
              fontFamily: 'Grapalat',
              fontSize: 23,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.textLineOrBackGroundColor,
            ),
          ),
        ),
      ),
      body: Scrollbar(
          thickness: 3,
          radius: const Radius.circular(12),
          isAlwaysShown: true,
          showTrackOnHover: true,
          child: ListView.builder(
            itemCount: libraryPages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: ListTile(
                  trailing: libraryPages[index],
                  onTap: () {
                    setState(() {
                      isColorAvtive = !isColorAvtive;
                      print(libraryPages[index]);
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AxotqScreen(),
                      ),
                    );
                  },
                ),
              );
            },
          )),
    );
  }
}

// class MyItem extends StatelessWidget {
//   final int? index;
//   final List<Widget>? listsData;

//   const MyItem({Key? key, this.index, this.listsData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final color = Colors.primaries[index! % Colors.primaries.length];
//     final hexRgb = color.shade500.toString().substring(10, 16).toUpperCase();
//     return const ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       trailing: Text('$listsData[]'),
//     );
//   }
// }
