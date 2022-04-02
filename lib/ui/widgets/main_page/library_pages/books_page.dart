import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'package:mashtoz_flutter/domens/models/categoy_list.dart';

import '/config/palette.dart';
import '/globals.dart';
import '../../helper_widgets/actions_widgets.dart';
import '/domens/fake_book_data.dart';
import '/domens/models/book.dart';
import 'book_page.dart';

class AxotqScreen extends StatefulWidget {
  const AxotqScreen({Key? key}) : super(key: key);

  @override
  State<AxotqScreen> createState() => _AxotqScreenState();
}

class _AxotqScreenState extends State<AxotqScreen> {
  var libraryList = <Content>[];
  void getLibrarayYbooks() async {
    // var contets;zzzzzzz
    //   try {
    var response = await http.get(
      Uri.parse(Api.libraryCategoryById(2)),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    var body = json.decode(response.body);

    var success = body['success'];
    if (success == true) {
      // print('succes');
      var content = body['data']['content'];
      print('getoteorfkldfk : ${content.runtimeType}');
      Map.from(content).forEach((key, value) {
        if (key.toString().contains(Map.from(value).values.first.toString())) {
          var data = Content.fromJson(value);
          libraryList.add(data);
          print("kEEEEEEEEEEEEEEEEEEEEEEY::${key}");
        }
      });
    } else {
      print("failed");
    }
  }

  List<Content> parsedContents(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    final content = parsed['data']['content'];
    return content.map<Content>((json) => Content.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLibrarayYbooks();
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: ListView.builder(
  //           itemCount: libraryList.length,
  //           itemBuilder: (context, index) {
  //             print(libraryList.length);
  //             Content book = libraryList[index];
  //             // inspect(book);
  //             return ListTile(
  //               title: Text('${book.author}'),
  //             );
  //           }),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Palette.textLineOrBackGroundColor,
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
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {
                  Content book = libraryList[index];
                  print(libraryList.length);
                  // book.content!.map((e,k)=> k.content.values.first.);
                  // return Center(
                  //     child: Container(
                  //         height: 20000,
                  //         child: Text(book.content!.values.first.content!.values
                  //             .first.content!.values.first.body!)));

                  return index % 2 != 0
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: _BookCard(
                              isOdd: true,
                              book: book,
                            ),
                          ))
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: _BookCard(
                            isOdd: false,
                            book: book,
                          ),
                        );
                },
                childCount: libraryList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  final Content book;
  final bool isOdd;
  const _BookCard({
    Key? key,
    required this.book,
    required this.isOdd,
  }) : super(key: key);
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
                            width: 350, semanticsLabel: 'group5040'),
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
                      top: 0,
                      left: 151,
                      child: isOdd
                          ? Transform(
                              transform: Matrix4.rotationY(math.pi),
                              alignment: Alignment.center,
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
                            )
                          : Text(
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
