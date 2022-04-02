import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/retry.dart';

import '../../../../config/palette.dart';
import '../../../../domens/fake_italian_lesson.dart';
import '../../../../domens/models/categoy_list.dart';
import '../../helper_widgets/actions_widgets.dart';
import 'book_read_screen.dart';

class BookInitalScreen extends StatefulWidget {
  const BookInitalScreen({Key? key, required this.book}) : super(key: key);

  final Content book;

  @override
  State<BookInitalScreen> createState() => _BookInitalScreenState(book: book);
}

class _BookInitalScreenState extends State<BookInitalScreen> {
  _BookInitalScreenState({required this.book});

  Content book;
  final ialianLesson = italianLessons;
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 73,
            backgroundColor: Palette.textLineOrBackGroundColor,
            pinned: false,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            flexibleSpace: ActionsHelper(
              leftPadding: 50,
              // botomPadding: 0,
              // topPadding: 30,
              text: 'Աղոթք',
              fontFamily: 'Grapalat',
              fontSize: 20,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.appBarTitleColor,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 426,
                  height: 275,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 90,
                          left: 0,
                          child: Container(
                              width: 426,
                              height: 185,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(164, 171, 189, 1),
                              ))),
                      Positioned(
                          top: 0,
                          left: 125,
                          child: SizedBox(
                              width: 138,
                              height: 180,
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
                                            color:
                                                Color.fromRGBO(51, 51, 51, 1),
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
                                      // decoration: const BoxDecoration(
                                      //   image: DecorationImage(
                                      //       image: AssetImage(
                                      //           'assets/images/Rectangle3772.png'),
                                      //       fit: BoxFit.fitWidth),
                                      // ),
                                    )),
                              ]))),
                      Positioned(
                          top: 193,
                          left: 70,
                          child: Text(
                            book.title ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(25, 4, 18, 1),
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          )),
                      Positioned(
                        top: 229,
                        left: 96,
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
                              SvgPicture.asset('assets/images/այքըններ.svg'),
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
                              SvgPicture.asset('assets/images/վելացնել1.svg'),
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
                itemCount: book.content!.length,
                //itemCount: 10,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final bovandak = book.content?.values.map((e) => e).toList();
                  final subBovandak =
                      bovandak?[index].content?.values.map((e) => e).toList();
                  return isValid
                      ? ExpansionTile(
                          onExpansionChanged: (value) {
                            if (value != null) {
                              print(" ok");
                            } else {
                              print("Show a toast, Please check all Fields");
                            }
                          },
                          collapsedIconColor:
                              const Color.fromRGBO(250, 147, 114, 1),
                          textColor: const Color.fromRGBO(84, 112, 126, 1),
                          iconColor: Palette.whenTapedButton,
                          title: Text(
                            '${bovandak?[index].title}',
                            style: TextStyle(
                                color: Color.fromRGBO(84, 112, 126, 1)),
                          ),
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                // itemCount: nestedContetnt?.map((e) => e.title).length,
                                itemCount: subBovandak?.length,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index2) {
                                  print("SubBovanda:::${subBovandak}");
                                  return ExpansionTile(
                                    collapsedIconColor:
                                        const Color.fromRGBO(250, 147, 114, 1),
                                    iconColor:
                                        const Color.fromRGBO(250, 147, 114, 1),
                                    title: Text(
                                      '${subBovandak?[index2].title}',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(113, 141, 156, 1)),
                                    ),
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 2,
                                          // itemCount: 10,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemBuilder: (context, index3) {
                                            return InkWell(
                                              onTap: () {
                                                print('fuck');
                                              },
                                              child: Text(
                                                  "{subContent?[index3].title}"),
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
                                }),
                          ],
                        )
                      : Container(
                          child: Text('dadas'),
                        );
                }),
          ),
        ],
      ),
    );
  }
}

class InitailContent extends StatelessWidget {
  const InitailContent({Key? key, required this.contents, required this.index})
      : super(key: key);
  final List<Content> contents;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: const Color.fromRGBO(250, 147, 114, 1),
      textColor: const Color.fromRGBO(84, 112, 126, 1),
      iconColor: Palette.whenTapedButton,
      title: Text(
        '${contents[index].title}',
        style: TextStyle(color: Color.fromRGBO(84, 112, 126, 1)),
      ),
      children: [
        Content1(
          contents: contents[index].content?.values.map((e) => e).toList(),
        ),
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount:
        //         nestedContetnt?.map((e) => e.id).length,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemBuilder: (context, index2) {
        //       final subContent = nestedContetnt?[index2]
        //           .content
        //           ?.values
        //           .map((e) => e)
        //           .toList();
        //       print('nestedContent ');
        //       return ExpansionTile(
        //         collapsedIconColor:
        //             const Color.fromRGBO(250, 147, 114, 1),
        //         iconColor:
        //             const Color.fromRGBO(250, 147, 114, 1),
        //         title: Text(
        //           '${nestedContetnt?[index2].title}',
        //           style: TextStyle(
        //               color:
        //                   Color.fromRGBO(113, 141, 156, 1)),
        //         ),
        //         children: [
        //           Container(
        //             child: ListView.builder(
        //                 physics:
        //                     const NeverScrollableScrollPhysics(),
        //                 shrinkWrap: true,
        //                 itemCount:
        //                     subContent?.map((e) => e).length,
        //                 itemBuilder: (context, index3) {
        //                   print('subContent ');
        //                   return ListTile(
        //                       onTap: () {
        //                         Navigator.push(
        //                             context,
        //                             MaterialPageRoute(
        //                                 builder: (context) =>
        //                                     BookReadScreen()));
        //                       },
        //                       title: Text(
        //                           "${subContent?[index3].title}"));
        //                 }),
        //           ),
        //         ],
        //       );
        //     }),
      ],
    );
  }
}

class Content1 extends StatelessWidget {
  const Content1({
    Key? key,
    required this.contents,
  }) : super(key: key);
  final List<Content>? contents;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: contents?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index2) {
          return Text('data');
          // return Content2(
          //   contents: contents!,
          //   index: index2,
          // );
          // return Content2();
        });
  }
}

class Content2 extends StatelessWidget {
  const Content2({Key? key, required this.contents, required this.index})
      : super(key: key);
  final List<Content> contents;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: const Color.fromRGBO(250, 147, 114, 1),
      iconColor: const Color.fromRGBO(250, 147, 114, 1),
      title: Text(
        '${contents[index].title}',
        style: TextStyle(color: Color.fromRGBO(113, 141, 156, 1)),
      ),
      children: [
        Content3(
          contents: contents,
        )
      ],
    );
  }
}

class Content3 extends StatelessWidget {
  const Content3({Key? key, required this.contents}) : super(key: key);
  final List<Content> contents;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: contents.map((e) => e).length,
          itemBuilder: (context, index3) {
            print('subContent ');
            return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookReadScreen()));
                },
                title: Text("${contents[index3].title}"));
          }),
    );
  }
}
