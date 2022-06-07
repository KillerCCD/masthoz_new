import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';

import 'package:mashtoz_flutter/domens/models/book_data/content_list.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/ui/widgets/buttons/bottom_navigation_bar/bottom_app_bar.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/size_config.dart';

import '../../helper_widgets/menuShow.dart';
import '/config/palette.dart';

import 'book_inherited_widget.dart';
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
    final orentation = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Palette.textLineOrBackGroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 20.0),
                child: Container(
                  height: 73,
                  width: MediaQuery.of(context).size.width - 90,
                  padding: EdgeInsets.only(top: 18),
                  child: Text(
                    '${category?.categoryTitle}',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                      fontFamily: 'GHEAGrapalat',
                      fontWeight: FontWeight.w700,
                      color: Palette.appBarTitleColor,
                    ),
                  ),
                ),
              ),
            ),
            leading: SizedBox(
              width: 8,
              height: 14,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Palette.appBarTitleColor,
                ),
              ),
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
          // SliverAppBar(
          //   expandedHeight: 73,
          //   backgroundColor: Palette.textLineOrBackGroundColor,
          //   pinned: false,
          //   floating: true,
          //   elevation: 0,
          //   automaticallyImplyLeading: false,
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //       statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
          //   title: Text(
          //     '${category?.categoryTitle}',
          //     style: TextStyle(
          //       fontFamily: 'GHEAGrapalat',
          //       fontSize: 20,
          //       letterSpacing: 1,
          //       fontWeight: FontWeight.bold,
          //       color: Palette.appBarTitleColor,
          //     ),
          //   ),
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(
          //       Icons.arrow_back_ios_new_outlined,
          //       color: Palette.appBarTitleColor,
          //     ),
          //   ),
          //   actions: [MenuShow()],
          // ),
          SliverFillRemaining(
            child: FutureBuilder<List<Content>>(
              future: contentFuture,
              builder: ((context, snapshot) {
                var conentList = snapshot.data;
                inspect(conentList);
                if (snapshot.hasData) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.7,
                        crossAxisCount:
                            orentation.width >= 800 && orentation.width < 1300
                                ? 2
                                : orentation.width >= 1300 &&
                                        orentation.width < 1600
                                    ? 3
                                    : orentation.width >= 1600
                                        ? 4
                                        : 1,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Content book = conentList![index];
                        return index % 2 != 0
                            ? Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: BookCard(
                                    isOdd: true,
                                    book: book,
                                    categorys: category!,
                                  ),
                                ))
                            : Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: BookCard(
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

class BookCard extends StatelessWidget {
  const BookCard({
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (_) => BookInitalScreen(
                book: book,
                category: categorys,
              ),
            ),
          );

          context.read<ContentProvider>().getContentList(book);
          print(book.title);
        },
        child: SizedBox(
          width: 388,
          height: 169,
          child: Stack(
            children: [
              Positioned(
                  top: 147,
                  left: 0,
                  child: SizedBox(
                      width: 320,
                      height: 14,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 320,
                                height: 14,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      height: 14,
                                      width: 320,
                                      child: CustomPaint(
                                        foregroundPainter: BookBox(),
                                      ),
                                    ),
                                  ),
                                  // child: Stack(children: <Widget>[
                                  //   Positioned(
                                  //     top: 0,
                                  //     left: 0,
                                  //     child: SizedBox(
                                  //       width: 388,
                                  //       child:
                                  //     ),
                                  //   ),
                                  //   // Positioned(
                                  //   //     top: 14,
                                  //   //     child: SizedBox(
                                  //   //       width: 388,
                                  //   //       child: Transform.rotate(
                                  //   //         angle: 179.99999499104388 *
                                  //   //             (math.pi / 180),
                                  //   //         child: SvgPicture.asset(
                                  //   //           'assets/images/rectangle3649.svg',
                                  //   //         ),
                                  //   //       ),
                                  //   //     )),
                                  // ]
                                ]))),

                        // Positioned(
                        //   top: 0,
                        //   left: 0,
                        //   child: SvgPicture.asset(
                        //     'assets/images/group5040.svg',
                        //     width: 330,
                        //   ),
                        // ),
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
                    child: Expanded(
                      child: isOdd
                          ? Transform(
                              transform: Matrix4.rotationY(math.pi),
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl: book.image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: book.image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  )),

              // Positioned(
              //     top: 155,
              //     right: 0,
              //     child: Container(
              //       width: 388,
              //       height: 14,
              //       child: Positioned(
              //         top: 0,
              //         left: 0,
              //         child: SvgPicture.asset(
              //           'assets/images/group5040.svg',
              //           color: null,
              //         ),
              //       ),
              //     )),
              Positioned.fill(
                bottom: 30.0,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 200,
                    height: 10,
                    child: isOdd
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform(
                              transform: Matrix4.rotationY(math.pi),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/vector81.svg',
                                color: Palette.main,
                                fit: BoxFit.none,
                                // semanticsLabel: 'vector81',
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: SvgPicture.asset(
                              'assets/images/vector81.svg',
                              color: Palette.main,
                              fit: BoxFit.none,
                              // semanticsLabel: 'vector81',
                            ),
                          ),
                  ),
                ),
              ),

              Positioned.fill(
                left: 100,
                child: isOdd
                    ? Align(
                        alignment: book.title!.isNotEmpty
                            ? Alignment.topCenter
                            : Alignment.center,
                        child: Container(
                          child: Transform(
                            transform: Matrix4.rotationY(math.pi),
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.only(top: 5.0),
                              //  width: 200,

                              width: SizeConfig.screenWidth! <= 384 ? 110 : 200,
                              child: Text(
                                book.title ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color.fromRGBO(25, 4, 18, 1),
                                    fontSize: 12,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'GHEAGrapalat',
                                    height: 1),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Align(
                        alignment: book.title!.isNotEmpty
                            ? Alignment.topCenter
                            : Alignment.center,
                        child: Container(
                          padding: book.title!.isNotEmpty
                              ? EdgeInsets.only(top: 5.0)
                              : EdgeInsets.only(top: 0.0),
                          width: SizeConfig.screenWidth! <= 384 ? 120 : 200,
                          child: Text(
                            book.title ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color.fromRGBO(25, 4, 18, 1),
                                fontSize: 12,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'GHEAGrapalat',
                                height: 1),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
              ),
              Positioned.fill(
                top: 66,
                left: 100,
                child: isOdd
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: Transform(
                            transform: Matrix4.rotationY(math.pi),
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: SizeConfig.screenWidth! <= 384 ? 120 : 200,
                              child: Text(
                                book.author ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color.fromRGBO(25, 4, 18, 1),
                                    fontSize: 12,
                                    letterSpacing: 1,
                                    fontFamily: 'GHEAGrapalat',
                                    fontWeight: FontWeight.w400,
                                    height: 1),
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          // color: Colors.orange,
                          child: SizedBox(
                            width: SizeConfig.screenWidth! <= 384 ? 120 : 200,
                            child: Text(
                              book.author ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: const Color.fromRGBO(25, 4, 18, 1),
                                  fontSize: 12,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'GHEAGrapalat',
                                  height: 1),
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          // child: Stack(
          //   children: <Widget>[
          //     Positioned(
          //         top: 147,
          //         left: 0,
          //         child: Container(
          //             width: 388,
          //             height: 8,
          //             decoration: const BoxDecoration(
          //               color: Color.fromRGBO(122, 108, 115, 1),
          //             ))),
          //     Positioned(
          //         top: 155,
          //         left: 0,
          //         child: SizedBox(
          //             width: 388,
          //             height: 14,
          //             child: Stack(children: <Widget>[
          //               Positioned(
          //                 top: 0,
          //                 left: 0,
          //                 child: SvgPicture.asset('assets/images/group5040.svg',
          //                     width: 380, semanticsLabel: 'group5040'),
          //               ),
          //             ]))),
          //     Positioned(
          //         top: 0,
          //         left: 14,
          //         child: Container(
          //             width: 116,
          //             height: 148,
          //             decoration: const BoxDecoration(
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: Color.fromARGB(24, 0, 0, 0),
          //                     offset: Offset(4, -4),
          //                     blurRadius: 1)
          //               ],
          //               color: Color.fromRGBO(164, 171, 189, 1),
          //             ))),
          //     Positioned(
          //         top: 17,
          //         left: 26,
          //         child: Container(
          //             width: 91,
          //             height: 113,
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                 color: const Color.fromRGBO(255, 255, 255, 1),
          //                 width: 1,
          //               ),
          //             ))),
          //     Positioned(
          //         top: 21.0,
          //         left: 30,
          //         child: SizedBox(
          //           width: 83,
          //           height: 104.0,
          //           child: CachedNetworkImage(
          //             imageUrl: book.image!,
          //             fit: BoxFit.cover,
          //           ),
          //         )),
          //     Container(
          //       padding: const EdgeInsets.only(left: 20.0, bottom: 20),
          //       child: InkWell(
          //         onTap: () {
          //           print('cikiTaki');

          //           Navigator.of(context, rootNavigator: true).push(
          //             MaterialPageRoute(
          //               builder: (_) => BookInitalScreen(
          //                 book: book,
          //                 category: categorys,
          //               ),
          //             ),
          //           );
          //           print(book.author);
          //         },
          //         child: Stack(
          //           children: [
          //             Positioned(
          //               top: 130,
          //               right: 100,
          //               child: isOdd
          //                   ? Transform(
          //                       transform: Matrix4.rotationY(math.pi),
          //                       alignment: Alignment.center,
          //                       child: SvgPicture.asset(
          //                         'assets/images/vector81.svg',
          //                         color: Palette.main,
          //                         // semanticsLabel: 'vector81',
          //                       ),
          //                     )
          //                   : SvgPicture.asset(
          //                       'assets/images/vector81.svg',
          //                       color: Palette.main,
          //                       // semanticsLabel: 'vector81',
          //                     ),
          //             ),
          //             Positioned(
          //               top: 5,
          //               left: 141,
          //               child: isOdd
          //                   ? Transform(
          //                       transform: Matrix4.rotationY(math.pi),
          //                       alignment: Alignment.center,
          //                       child: SizedBox(
          //                         width: 200,
          //                         child: Text(
          //                           book.author ?? '',
          //                           textAlign: TextAlign.center,
          //                           style: const TextStyle(
          //                               color: Color.fromRGBO(25, 4, 18, 1),
          //                               fontSize: 12,
          //                               letterSpacing: 1,
          //                               fontWeight: FontWeight.w700,
          //                               fontFamily: 'GHEAGrapalat',
          //                               height: 1),
          //                           maxLines: 3,
          //                           overflow: TextOverflow.ellipsis,
          //                         ),
          //                       ),
          //                     )
          //                   : SizedBox(
          //                       width: 200,
          //                       child: Text(
          //                         book.author ?? '',
          //                         textAlign: TextAlign.center,
          //                         style: const TextStyle(
          //                             color: Color.fromRGBO(25, 4, 18, 1),
          //                             fontSize: 12,
          //                             letterSpacing: 1,
          //                             fontWeight: FontWeight.w700,
          //                             fontFamily: 'GHEAGrapalat',
          //                             height: 1),
          //                         maxLines: 3,
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ),
          //             ),
          //             Positioned(
          //               top: 95,
          //               left: 141,
          //               child: isOdd
          //                   ? Transform(
          //                       transform: Matrix4.rotationY(math.pi),
          //                       alignment: Alignment.center,
          //                       child: SizedBox(
          //                         width: 200,
          //                         child: Text(
          //                           book.title ?? '',
          //                           textAlign: TextAlign.center,
          //                           style: const TextStyle(
          //                               color: Color.fromRGBO(25, 4, 18, 1),
          //                               fontSize: 12,
          //                               letterSpacing: 1,
          //                               fontFamily: 'GHEAGrapalat',
          //                               fontWeight: FontWeight.w400,
          //                               height: 1),
          //                         ),
          //                       ),
          //                     )
          //                   : SizedBox(
          //                       width: 200,
          //                       child: Text(
          //                         book.title ?? '',
          //                         textAlign: TextAlign.center,
          //                         style: const TextStyle(
          //                             color: const Color.fromRGBO(25, 4, 18, 1),
          //                             fontSize: 12,
          //                             letterSpacing: 1,
          //                             fontWeight: FontWeight.w400,
          //                             fontFamily: 'GHEAGrapalat',
          //                             height: 1),
          //                       ),
          //                     ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
// class _BookCard extends StatelessWidget {
//   final Content book;
//   final bool isOdd;
//   const _BookCard({
//     Key? key,
//     required this.book,
//     required this.isOdd,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 388,
//         height: 169,
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//                 top: 147,
//                 left: 0,
//                 child: Container(
//                     width: 388,
//                     height: 8,
//                     decoration: const BoxDecoration(
//                       color: Color.fromRGBO(122, 108, 115, 1),
//                     ))),
//             Positioned(
//                 top: 155,
//                 left: 0,
//                 child: SizedBox(
//                     width: 388,
//                     height: 14,
//                     child: Stack(children: <Widget>[
//                       Positioned(
//                         top: 0,
//                         left: 0,
//                         child: SvgPicture.asset('assets/images/group5040.svg',
//                             width: 380, semanticsLabel: 'group5040'),
//                       ),
//                     ]))),
//             Positioned(
//                 top: 0,
//                 left: 14,
//                 child: Container(
//                     width: 116,
//                     height: 148,
//                     decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color.fromARGB(24, 0, 0, 0),
//                             offset: Offset(4, -4),
//                             blurRadius: 1)
//                       ],
//                       color: Color.fromRGBO(164, 171, 189, 1),
//                     ))),
//             Positioned(
//                 top: 17,
//                 left: 26,
//                 child: Container(
//                     width: 91,
//                     height: 113,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: const Color.fromRGBO(255, 255, 255, 1),
//                         width: 1,
//                       ),
//                     ))),
//             Positioned(
//                 top: 21.0,
//                 left: 30,
//                 child: SizedBox(
//                   width: 83,
//                   height: 104.0,
//                   child: CachedNetworkImage(
//                     imageUrl: book.image!,
//                     fit: BoxFit.cover,
//                   ),
//                 )),
//             Container(
//               padding: const EdgeInsets.only(left: 20.0, bottom: 20),
//               child: InkWell(
//                 onTap: () {
//                   print('cikiTaki');
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => BookInitalScreen(
//                         book: book,
//                       ),
//                     ),
//                   );
//                   print(book.author);
//                 },
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 130,
//                       right: 100,
//                       child: isOdd
//                           ? Transform(
//                               transform: Matrix4.rotationY(math.pi),
//                               alignment: Alignment.center,
//                               child: SvgPicture.asset(
//                                 'assets/images/vector81.svg',
//                                 color: Palette.main,
//                                 // semanticsLabel: 'vector81',
//                               ),
//                             )
//                           : SvgPicture.asset(
//                               'assets/images/vector81.svg',
//                               color: Palette.main,
//                               // semanticsLabel: 'vector81',
//                             ),
//                     ),
//                     Positioned(
//                       top: 50,
//                       left: 151,
//                       child: isOdd
//                           ? Transform(
//                               transform: Matrix4.rotationY(math.pi),
//                               alignment: Alignment.center,
//                               child: SizedBox(
//                                 width: 200,
//                                 child: Text(
//                                   book.author ?? '',
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                       color: Color.fromRGBO(25, 4, 18, 1),
//                                       fontSize: 12,
//                                       letterSpacing: 0,
//                                       fontWeight: FontWeight.normal,
//                                       height: 1),
//                                 ),
//                               ),
//                             )
//                           : SizedBox(
//                               width: 200,
//                               child: Text(
//                                 book.author ?? '',
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                     color: Color.fromRGBO(25, 4, 18, 1),
//                                     fontSize: 12,
//                                     letterSpacing: 0,
//                                     fontWeight: FontWeight.normal,
//                                     height: 1),
//                               ),
//                             ),
//                     ),
//                     Positioned(
//                       top: 60,
//                       left: 160,
//                       child: isOdd
//                           ? Transform(
//                               transform: Matrix4.rotationY(math.pi),
//                               alignment: Alignment.center,
//                               child: Text(
//                                 book.explanation ?? '',
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                     color: Color.fromRGBO(25, 4, 18, 1),
//                                     fontSize: 12,
//                                     letterSpacing: 0,
//                                     fontWeight: FontWeight.normal,
//                                     height: 1),
//                               ),
//                             )
//                           : Text(
//                               book.explanation ?? '',
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                   color: const Color.fromRGBO(25, 4, 18, 1),
//                                   fontSize: 12,
//                                   letterSpacing: 0,
//                                   fontWeight: FontWeight.normal,
//                                   height: 1),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
