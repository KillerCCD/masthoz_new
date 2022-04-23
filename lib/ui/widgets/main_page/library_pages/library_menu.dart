import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';

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
  final bookDataProvider = BookDataProvider();
  Future<List<BookCategory>>? categoryFutureList;
  bool isColorAvtive = false;

  @override
  void initState() {
    categoryFutureList = bookDataProvider.getCategoryLists();
    super.initState();
  }

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
              text: 'Գրադարան',
              fontFamily: 'Grapalat',
              fontSize: 23,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.textLineOrBackGroundColor,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<BookCategory>>(
        future: categoryFutureList,
        builder: (context, snapshot) {
          var categoryList = snapshot.data;
          if (snapshot.hasData) {
            return Scrollbar(
                thickness: 3,
                radius: const Radius.circular(12),
                isAlwaysShown: true,
                showTrackOnHover: true,
                child: ListView.builder(
                  itemCount: categoryList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      width: 500,
                      padding: const EdgeInsets.only(right: 0),
                      child: ListTile(
                        trailing: Text(
                          '${categoryList[index].categoryTitle}',
                          style: TextStyle(
                            color: Palette.textLineOrBackGroundColor,
                            fontSize: 15,
                            fontFamily: 'Grapalat',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            isColorAvtive = !isColorAvtive;
                            print(categoryList[index].id);
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
                      ),
                    );
                  },
                ));
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
    );
  }
}
