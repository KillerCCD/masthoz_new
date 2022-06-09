import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/menuShow.dart';
import 'package:provider/provider.dart';

import 'book_inherited_widget.dart';
import 'books_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final bookDataProvider = BookDataProvider();
  Future<List<BookCategory>>? categoryFutureList;
  bool isColorAvtive = false;

  @override
  void initState() {
    categoryFutureList = bookDataProvider.getCategoryLists(Api.categoryListUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: Colors.amber)),
      child: Scaffold(
        backgroundColor: Palette.libraryBacgroundColor,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(73),
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(25, 4, 18, 1),
            ),
            elevation: 0,
            title: Text(
              'Գրադարան',
              style: TextStyle(
                  fontFamily: 'GHEAGrapalat',
                  fontSize: 18,
                  letterSpacing: 1.5 ,
                  fontWeight: FontWeight.bold,
                  color: Palette.textLineOrBackGroundColor),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Palette.barColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: MenuShow(),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: FutureBuilder<List<BookCategory>>(
            future: categoryFutureList,
            builder: (context, snapshot) {
              var categoryList = snapshot.data;
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: RawScrollbar(
                          thumbColor: Palette.whenTapedButton,
                          thickness: 3,
                          radius: const Radius.circular(12),
                          isAlwaysShown: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: categoryList!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(right: 26),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isColorAvtive = !isColorAvtive;

                                      ;
                                    });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BooksScreen(
                                          category: categoryList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${categoryList[index].categoryTitle}',
                                      style: TextStyle(
                                        color:
                                            Palette.textLineOrBackGroundColor,
                                        fontSize: 12,
                                        fontFamily: 'GHEAGrapalat',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                );
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Palette.main,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
