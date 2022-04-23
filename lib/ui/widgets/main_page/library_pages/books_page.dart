import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';

import 'package:mashtoz_flutter/domens/models/book_data/content_list.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';

import '/config/palette.dart';
import '../../helper_widgets/actions_widgets.dart';

import 'book_page.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  final BookCategory? category;

  @override
  State<BooksScreen> createState() => _BooksScreenState(
        category: category,
      );
}

class _BooksScreenState extends State<BooksScreen> {
  _BooksScreenState({
    required this.category,
  });

  final bookDataProvider = BookDataProvider();
  Future<List<Content>>? contentFuture;
  final BookCategory? category;

  @override
  void initState() {
    contentFuture = bookDataProvider.getLibrarayYbooksById(category!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Palette.textLineOrBackGroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 73,
            backgroundColor: Palette.textLineOrBackGroundColor,
            pinned: false,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            // title: ActionsHelper(
            //   // botomPadding: 0,
            //   topPadding: 30,
            //   text: '${idCategory?.categoryTitle}',
            //   fontFamily: 'Grapalat',
            //   fontSize: 20,
            //   laterSpacing: 1,
            //   fontWeight: FontWeight.bold,
            //   color: Palette.appBarTitleColor,
            //   buttonShow: true,
            // ),
            flexibleSpace: ActionsHelper(
              // botomPadding: 0,
              topPadding: 30,
              text: '${category?.categoryTitle}',
              fontFamily: 'Grapalat',
              fontSize: 20,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.appBarTitleColor,
              buttonShow: true,
            ),
          ),
          SliverFillRemaining(
            child: FutureBuilder<List<Content>>(
              future: contentFuture,
              builder: ((context, snapshot) {
                var conentList = snapshot.data;
                inspect(conentList);
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: conentList!.length,
                      itemBuilder: (context, index) {
                        Content book = conentList[index];
                        return index % 2 != 0
                            ? Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: _BookCard(
                                    isOdd: true,
                                    book: book,
                                    categorys: category!,
                                  ),
                                ))
                            : Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: _BookCard(
                                  isOdd: false,
                                  book: book,
                                  categorys: category!,
                                ),
                              );
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Palette.main,
                )));
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  const _BookCard({
    Key? key,
    required this.book,
    required this.isOdd,
    required this.categorys,
  }) : super(key: key);

  final Content book;
  final bool isOdd;
  final BookCategory categorys;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 388,
        height: 169,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 147,
                left: 0,
                child: Container(
                    width: 388,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(122, 108, 115, 1),
                    ))),
            Positioned(
                top: 155,
                left: 0,
                child: SizedBox(
                    width: 388,
                    height: 14,
                    child: Stack(children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: SvgPicture.asset('assets/images/group5040.svg',
                            width: 380, semanticsLabel: 'group5040'),
                      ),
                    ]))),
            Positioned(
                top: 0,
                left: 14,
                child: Container(
                    width: 116,
                    height: 148,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(24, 0, 0, 0),
                            offset: Offset(4, -4),
                            blurRadius: 1)
                      ],
                      color: Color.fromRGBO(164, 171, 189, 1),
                    ))),
            Positioned(
                top: 17,
                left: 26,
                child: Container(
                    width: 91,
                    height: 113,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        width: 1,
                      ),
                    ))),
            Positioned(
                top: 21.0,
                left: 30,
                child: SizedBox(
                  width: 83,
                  height: 104.0,
                  child: CachedNetworkImage(
                    imageUrl: book.image!,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20),
              child: InkWell(
                onTap: () {
                  print('cikiTaki');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookInitalScreen(
                        book: book,
                        category: categorys,
                      ),
                    ),
                  );
                  print(book.author);
                },
                child: Stack(
                  children: [
                    Positioned(
                      top: 130,
                      right: 100,
                      child: isOdd
                          ? Transform(
                              transform: Matrix4.rotationY(math.pi),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/vector81.svg',
                                color: Palette.main,
                                // semanticsLabel: 'vector81',
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/images/vector81.svg',
                              color: Palette.main,
                              // semanticsLabel: 'vector81',
                            ),
                    ),
                    Positioned(
                      top: 50,
                      left: 151,
                      child: isOdd
                          ? Transform(
                              transform: Matrix4.rotationY(math.pi),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 200,
                                child: Text(
                                  book.author ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(25, 4, 18, 1),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 200,
                              child: Text(
                                book.author ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color.fromRGBO(25, 4, 18, 1),
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ),
                    ),
                    Positioned(
                      top: 60,
                      left: 160,
                      child: isOdd
                          ? Transform(
                              transform: Matrix4.rotationY(math.pi),
                              alignment: Alignment.center,
                              child: Text(
                                book.explanation ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color.fromRGBO(25, 4, 18, 1),
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            )
                          : Text(
                              book.explanation ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: const Color.fromRGBO(25, 4, 18, 1),
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
