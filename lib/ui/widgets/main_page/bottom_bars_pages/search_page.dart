import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mashtoz_flutter/domens/models/book_data/search_data.dart';
import 'package:mashtoz_flutter/domens/repository/search_book_data_provider.dart';
import 'dart:math' as math;

import '../../helper_widgets/menuShow.dart';
import '../library_pages/book_read_screen.dart';
import '/config/palette.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Search>>? booksSearchFuture;
  final controller = TextEditingController();
  Timer? debouncer;
  String query = '';
  final searchBookProvider = SearchBookProvider();

  var searchbooks = <Search>[];
  var searcjBookforDisplay = <Search>[];

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    init();
    controller.dispose();
    super.initState();
  }

  Future init() async {
    final books = await SearchBookProvider.fetchAllBooks(query);

    setState(() => this.searchbooks = books);
  }

  Future searchBook(String query) async => debounce(() async {
        final books = await SearchBookProvider.fetchAllBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.searchbooks = books;
        });
      });

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Palette.searchBackGroundColor,
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: CustomScrollView(
              slivers: [
                // ),
                SliverAppBar(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Որոնել',
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontFamily: 'GHEAGrapalat',
                          fontWeight: FontWeight.bold,
                          color: Palette.appBarTitleColor),
                    ),
                  ),
                  expandedHeight: 53,
                  backgroundColor: Palette.searchBackGroundColor,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
                  actions: [
                    MenuShow(),
                  ],
                ),
                SliverFillRemaining(
                  fillOverscroll: true,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(226, 224, 224, 1),
                                  ),
                                  borderRadius: BorderRadius.zero),
                              hintText: 'Գրել այստեղ․․․',
                              suffixIcon: Container(
                                height: double.infinity,
                                child: SvgPicture.asset(
                                  'assets/images/search.svg',
                                  semanticsLabel: 'search',
                                  color: Color.fromRGBO(122, 108, 115, 1),
                                ),
                              ),
                              suffixIconConstraints: BoxConstraints.tightFor(
                                  height: 30, width: 80)),
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: searchBook,
                        ),
                      ),

                      searchbooks.isNotEmpty
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 50.0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Որոնման արդյունքները',
                                    style: TextStyle(
                                        color: Color.fromRGBO(122, 108, 115, 1),
                                        fontFamily: "GHEAGrapalat",
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(height: 20.0),

                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: searchbooks.length,
                              itemBuilder: (context, index) {
                                final book = searchbooks[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (_) => BookReadScreen(
                                                  searchData: book,
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          height: 180,
                                          child: Stack(children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                  width: 116,
                                                  height: 160,
                                                  child: CachedNetworkImage(
                                                    imageUrl: book.image!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Positioned(
                                                top: 63,
                                                left: 126,
                                                child: Container(
                                                  width: 200,
                                                  child: Text(
                                                    "  ${book.title}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            25, 4, 18, 1),
                                                        fontFamily:
                                                            'GHEA GHEAGrapalat',
                                                        fontSize: 12,
                                                        letterSpacing:
                                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 1),
                                                    maxLines: 4,
                                                  ),
                                                )),
                                            Positioned(
                                                top: 156,
                                                left: 185,
                                                child: Transform.rotate(
                                                  angle: 0.1 * (math.pi / 180),
                                                  child: SvgPicture.asset(
                                                    'assets/images/vector81.svg',
                                                    semanticsLabel: 'vector81',
                                                    color: Palette.main,
                                                  ),
                                                )),
                                            Positioned(
                                                top: 180,
                                                left: 0,
                                                child: Transform.rotate(
                                                  angle:
                                                      0.000005008956538086317 *
                                                          (math.pi / 180),
                                                  child: Divider(
                                                      color: Color.fromRGBO(
                                                          122, 108, 115, 1),
                                                      thickness: 0.5),
                                                )),
                                          ])),
                                      Divider(
                                        thickness: 1,
                                        color: Color.fromRGBO(122, 108, 115, 1),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      )
                                    ],
                                  ),
                                );
                              })),

                  
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}



class MyFutureBuilder<T> extends StatelessWidget {
  MyFutureBuilder({
    Key? key,
    this.future,
    this.errorWidget,
    this.succesWidget,
  }) : super(key: key);

  final Widget Function(dynamic error)? errorWidget;
  final Widget Function(T data)? succesWidget;
  final Future<T>? future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.active:
        case ConnectionState.waiting:
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Palette.main,
          ));

        case ConnectionState.none:
          return Center(child: Text('Check Your Internet Connection'));
        case ConnectionState.done:
          if (snapshot.hasError) {
            return this.errorWidget != null
                ? this.errorWidget!(snapshot.error)
                : Center(child: Text('${snapshot.error}'));
          } else {
            return this.succesWidget!(snapshot.data!);
          }
        default:
          return Container();
      }
    });
  }
}
