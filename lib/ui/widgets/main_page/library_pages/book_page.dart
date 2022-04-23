import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';

import '../../../../config/palette.dart';

import '../../../../domens/models/book_data/content_list.dart';
import '../../helper_widgets/actions_widgets.dart';
import 'book_read_screen.dart';

class BookInitalScreen extends StatefulWidget {
  const BookInitalScreen({Key? key, required this.category, required this.book})
      : super(key: key);
  final BookCategory category;
  final Content book;

  @override
  State<BookInitalScreen> createState() =>
      _BookInitalScreenState(book: book, category: category);
}

class _BookInitalScreenState extends State<BookInitalScreen> {
  _BookInitalScreenState({required this.book, required this.category});

  Content book;
  final BookCategory category;
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return book.content != null
        ? Scaffold(
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
                  flexibleSpace: ActionsHelper(
                    // botomPadding: 0,
                    topPadding: 30,
                    text: '${category.categoryTitle}',
                    fontFamily: 'Grapalat',
                    fontSize: 20,
                    laterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: Palette.appBarTitleColor,
                    buttonShow: true,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: mediaQuery.width,
                        height: 275,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 90,
                                left: 0,
                                child: Container(
                                    width: mediaQuery.width,
                                    height: 185,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(164, 171, 189, 1),
                                    ))),
                            Container(
                                child: Center(
                              child: SizedBox(
                                  width: 138,
                                  height: mediaQuery.height / 2,
                                  child: Stack(children: <Widget>[
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                            width: 138,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    51, 51, 51, 1),
                                                width: 01,
                                              ),
                                            ))),
                                    Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          width: 122,
                                          height: 164,
                                          child: CachedNetworkImage(
                                            imageUrl: book.image!,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ])),
                            )),
                            Positioned(
                                top: 193,
                                left: mediaQuery.width / 5,
                                child: Container(
                                  width: 246,
                                  child: Text(
                                    "${book.title}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(25, 4, 18, 1),
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                )),
                            Positioned(
                              top: mediaQuery.height / 3.5,
                              left: mediaQuery.width / 4.5,
                              child: Container(
                                width: 246,
                                child: Text(
                                  book.author ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(25, 4, 18, 1),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          color: const Color.fromRGBO(246, 246, 246, 1),
                          width: double.infinity,
                          height: 49,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  print('kisvel');
                                },
                                child: Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    SvgPicture.asset(
                                        'assets/images/այքըններ.svg'),
                                    const SizedBox(width: 6),
                                    const Text('Կիսվել')
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print('share anel paterin');
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/վելացնել1.svg'),
                                    const SizedBox(width: 6),
                                    const Text('Պահել'),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 14),
                      const Center(
                          child: Text(
                        'Բովանդակություն',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: ListView.builder(
                      // itemBuilder: (context, index) => const Divider(
                      //       color: Color.fromRGBO(226, 224, 224, 1),
                      //     ),
                      itemCount: book.content?.length,
                      //itemCount: 10,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final bovandak =
                            book.content?.values.map((e) => e).toList();
                        final subBovandak = bovandak?[index]
                            .content
                            ?.values
                            .map((e) => e)
                            .toList();
                        return bovandak?[index].content != null
                            ? ExpansionTile(
                                collapsedIconColor:
                                    const Color.fromRGBO(250, 147, 114, 1),
                                textColor:
                                    const Color.fromRGBO(84, 112, 126, 1),
                                iconColor: Palette.whenTapedButton,
                                title: Text(
                                  '${bovandak?[index].title}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(84, 112, 126, 1)),
                                ),
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: subBovandak?.length,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, index2) {
                                        //   print("SubContent:::${subContent}");
                                        var subContent = subBovandak?[index2]
                                            .content
                                            ?.values
                                            .map(
                                              (e) => e,
                                            )
                                            .toList();
                                        return subBovandak?[index2].content !=
                                                null
                                            ? ExpansionTile(
                                                collapsedIconColor:
                                                    const Color.fromRGBO(
                                                        250, 147, 114, 1),
                                                iconColor: const Color.fromRGBO(
                                                    250, 147, 114, 1),
                                                title: Text(
                                                  '${subBovandak?[index2].title}',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          113, 141, 156, 1)),
                                                ),
                                                children: [
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          subContent?.length,
                                                      physics:
                                                          const ClampingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index3) {
                                                        Content readContent =
                                                            subContent![index3];
                                                        return InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (_) =>
                                                                    BookReadScreen(
                                                                        readScreen:
                                                                            readContent),
                                                              ),
                                                            );
                                                            print('Coco');
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12.0),
                                                            height: 60,
                                                            child: Text(
                                                              "${subContent[index3].title}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        );
                                                      }),

                                                  // Container(
                                                  //   child: ListView.builder(
                                                  //       physics:
                                                  //           const NeverScrollableScrollPhysics(),
                                                  //       shrinkWrap: true,
                                                  //       itemCount: slength,
                                                  //       itemBuilder: (context, index3) {
                                                  //         print('subContent ');
                                                  //         return ListTile(
                                                  //             onTap: () {
                                                  //               Navigator.push(
                                                  //                   context,
                                                  //                   MaterialPageRoute(
                                                  //                       builder: (context) =>
                                                  //                           BookReadScreen()));
                                                  //             },
                                                  //             title: Text(
                                                  //                 "${subContent?[index3].title}"));
                                                  //       }),
                                                  // ),
                                                ],
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          BookReadScreen(
                                                              readScreen:
                                                                  subBovandak![
                                                                      index2]),
                                                    ),
                                                  );
                                                  print('Coco');
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(12.0),
                                                  height: 60,
                                                  child: Text(
                                                    '${subBovandak?[index2].title}',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              );
                                      }),
                                ],
                              )
                            : ListTile(
                                textColor: Color.fromRGBO(84, 112, 126, 1),
                                title: Text('${bovandak?[index].title}'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BookReadScreen(
                                              readScreen: bovandak![index])));
                                },
                              );
                      }),
                ),
              ],
            ),
          )
        : BookReadScreen(readScreen: book);
  }
}

class GlobalBovandakLists extends StatefulWidget {
  GlobalBovandakLists({Key? key}) : super(key: key);

  @override
  State<GlobalBovandakLists> createState() => _GlobalBovandakListsState();
}

class _GlobalBovandakListsState extends State<GlobalBovandakLists> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // itemBuilder: (context, index) => const Divider(
        //       color: Color.fromRGBO(226, 224, 224, 1),
        //     ),
        //  itemCount: book.content?.length,
        itemCount: 10,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // final bovandak =
          //     book.content?.values.map((e) => e).toList();
          // final subBovandak = bovandak?[index]
          //     .content
          //     ?.values
          //     .map((e) => e)
          //     .toList();
          // return bovandak?[index].content != null
          //     ?
          return ExpansionTile(
            collapsedIconColor: const Color.fromRGBO(250, 147, 114, 1),
            textColor: const Color.fromRGBO(84, 112, 126, 1),
            iconColor: Palette.whenTapedButton,
            title: Text(
              '{bovandak?[index].title}',
              style: TextStyle(color: Color.fromRGBO(84, 112, 126, 1)),
            ),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  //itemCount: subBovandak?.length,
                  itemCount: 5,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index2) {
                    //   print("SubContent:::${subContent}");
                    // var subContent = subBovandak?[index2]
                    //     .content
                    //     ?.values
                    //     .map(
                    //       (e) => e,
                    //     )
                    //     .toList();
                    // return subBovandak?[index2].content !=
                    //         null
                    //     ?
                    return ExpansionTile(
                      collapsedIconColor:
                          const Color.fromRGBO(250, 147, 114, 1),
                      iconColor: const Color.fromRGBO(250, 147, 114, 1),
                      title: Text(
                        '{subBovandak?[index2].title}',
                        style:
                            TextStyle(color: Color.fromRGBO(113, 141, 156, 1)),
                      ),
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            // itemCount:
                            //     subContent?.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index3) {
                              // Content readContent =
                              //     subContent![index3];
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) =>
                                  //         BookReadScreen(
                                  //             readScreen:
                                  //                 readContent),
                                  //   ),
                                  // );
                                  print('Coco');
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  height: 60,
                                  child: Text(
                                    "{subContent[index3].title}",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              );
                            }),

                        // Container(
                        //   child: ListView.builder(
                        //       physics:
                        //           const NeverScrollableScrollPhysics(),
                        //       shrinkWrap: true,
                        //       itemCount: slength,
                        //       itemBuilder: (context, index3) {
                        //         print('subContent ');
                        //         return ListTile(
                        //             onTap: () {
                        //               Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) =>
                        //                           BookReadScreen()));
                        //             },
                        //             title: Text(
                        //                 "${subContent?[index3].title}"));
                        //       }),
                        // ),
                      ],
                    );
                    // : InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (_) =>
                    //               BookReadScreen(
                    //                   readScreen:
                    //                       subBovandak![
                    //                           index2]),
                    //         ),
                    //       );
                    //       print('Coco');
                    //     },
                    //     child: Container(
                    //       padding: EdgeInsets.all(12.0),
                    //       height: 60,
                    //       child: Text(
                    //         '${subBovandak?[index2].title}',
                    //         textAlign: TextAlign.start,
                    //       ),
                    //     ),
                    //   );
                  }),
            ],
          );
          // : ListTile(
          //     textColor: Color.fromRGBO(84, 112, 126, 1),
          //     title: Text('${bovandak?[index].title}'),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (_) => BookReadScreen(
          //                   readScreen: bovandak![index])));
          //     },
          //   );
        });
  }
}
