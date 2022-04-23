import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mashtoz_flutter/domens/models/book_data/search_data.dart';
import 'package:mashtoz_flutter/domens/repository/search_book_data_provider.dart';

import '../../helper_widgets/actions_widgets.dart';
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

  var _searchbooks = <Search>[];
  var _searcjBookforDisplay = <Search>[];

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    final books = await searchBookProvider.fetchBooks();

    setState(() => this._searchbooks = books);
  }

  Future searchBook(String query) async => debounce(() async {
        final books = await searchBookProvider.fetchBooks();

        if (!mounted) return;

        setState(() {
          this.query = query;
          this._searchbooks = books;
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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 73,
                backgroundColor: Palette.searchBackGroundColor,
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
                  text: 'Որոնել',
                  fontFamily: 'Grapalat',
                  fontSize: 20,
                  laterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: Palette.appBarTitleColor,
                ),
              ),
              SliverFillRemaining(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                            suffixIcon: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: SvgPicture.asset(
                                  'assets/images/search.svg',
                                  semanticsLabel: 'search',
                                  color: Color.fromRGBO(122, 108, 115, 1),
                                ),
                              ),
                            ),
                            suffixIconConstraints:
                                BoxConstraints.tightFor(height: 35, width: 36)),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: searchBook,
                      ),
                    ),
                    // Expanded(
                    //     child: ListView.builder(
                    //         shrinkWrap: true,
                    //         // scrollDirection: Axis.vertical,
                    //         itemCount: searchbooks.length,
                    //         itemBuilder: (context, index) {
                    //           final book = searchbooks[index];
                    //           return InkWell(
                    //             onTap: () {
                    //               // Navigator.push(context,MaterialPageRoute(builder: (_)=> BookReadScreen(readScreen: )))
                    //             },
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(12.0),
                    //               child: Container(
                    //                   width: 288,
                    //                   height: 180,
                    //                   child: Stack(children: <Widget>[
                    //                     Positioned(
                    //                         top: 0,
                    //                         left: 0,
                    //                         child: Container(
                    //                           width: 116,
                    //                           height: 160,
                    //                           child: CachedNetworkImage(
                    //                             imageUrl: book.imageUrl,
                    //                             fit: BoxFit.cover,
                    //                           ),
                    //                         )),
                    //                     Positioned(
                    //                         top: 63,
                    //                         left: 126,
                    //                         child: Text(
                    //                           book.bookName,
                    //                           textAlign: TextAlign.center,
                    //                           style: TextStyle(
                    //                               color: Color.fromRGBO(
                    //                                   25, 4, 18, 1),
                    //                               fontFamily: 'GHEA Grapalat',
                    //                               fontSize: 12,
                    //                               letterSpacing:
                    //                                   0 /*percentages not used in flutter. defaulting to zero*/,
                    //                               fontWeight: FontWeight.normal,
                    //                               height: 1),
                    //                         )),
                    //                     Positioned(
                    //                         top: 156,
                    //                         left: 185,
                    //                         child: Transform.rotate(
                    //                           angle: 0.1 * (math.pi / 180),
                    //                           child: SvgPicture.asset(
                    //                             'assets/images/vector81.svg',
                    //                             semanticsLabel: 'vector81',
                    //                             color: Palette.main,
                    //                           ),
                    //                         )),
                    //                     Positioned(
                    //                         top: 180,
                    //                         left: 0,
                    //                         child: Transform.rotate(
                    //                           angle: 0.000005008956538086317 *
                    //                               (math.pi / 180),
                    //                           child: Divider(
                    //                               color: Color.fromRGBO(
                    //                                   122, 108, 115, 1),
                    //                               thickness: 0.5),
                    //                         )),
                    //                   ])),
                    //             ),
                    //           );
                    //         })),

                    Expanded(
                        child: ListView.builder(
                            itemCount: _searchbooks.length,
                            itemBuilder: (contex, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 32.0,
                                      bottom: 32.0,
                                      left: 16.0,
                                      right: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _searchbooks[index].id.toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _searchbooks[index].title!,
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))
                    // Expanded(
                    //     child: MyFutureBuilder<List<Search>>(
                    //         future: booksSearchFuture!,
                    //         succesWidget: (List<Search> products) {
                    //           return ListView.separated(
                    //               itemCount: products.length,
                    //               separatorBuilder: (context, index) {
                    //                 return Divider(height: .1);
                    //               },
                    //               itemBuilder:
                    //                   (BuildContext context, int index) {
                    //                 Search p = products[index];
                    //                 return Padding(
                    //                   padding: EdgeInsets.symmetric(
                    //                       horizontal: 8, vertical: 1),
                    //                   child: Container(
                    //                     padding: EdgeInsets.all(8),
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.grey.withOpacity(.2),
                    //                     ),
                    //                     child: Column(children: [
                    //                       Row(children: [
                    //                         Text(' ${p.id}',
                    //                             style: TextStyle(
                    //                                 fontWeight:
                    //                                     FontWeight.w600)),
                    //                       ]),
                    //                       Container(
                    //                         child: Text(
                    //                           '${p.type}',
                    //                         ),
                    //                       ),
                    //                     ]),
                    //                   ),
                    //                 );
                    //               });
                    //         }))
                  ],
                ),
              )
            ],
          )),
    );
  }
}

// class MySearchDelegate extends SearchDelegate {
//   SearchBookProvider? searchBookProvider;
//   MySearchDelegate({this.searchBookProvider});
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.cancel),
//           onPressed: () {
//             this.query = "";
//           }),
//     ];
//   }

//   @override
//   buildResults(BuildContext context) {
//     if (query == '') return Container();
//     return MyFutureBuilder<List<Search>>(
//         future: this.searchBookProvider!.searchProducts(this.query),
//         succesWidget: (List<Search> products) {
//           return ListView.separated(
//               itemCount: products.length,
//               separatorBuilder: (context, index) {
//                 return Divider(height: .1);
//               },
//               itemBuilder: (BuildContext context, int index) {
//                 Search p = products[index];
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(.2),
//                     ),
//                     child: Column(children: [
//                       Row(children: [
//                         Text(' ${p.id}',
//                             style: TextStyle(fontWeight: FontWeight.w600)),
//                       ]),
//                       Container(
//                         child: Text(
//                           '${p.type}',
//                         ),
//                       ),
//                     ]),
//                   ),
//                 );
//               });
//         });
//   }

//   @override
//   buildLeading(BuildContext context) {
//     return IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {
//           this.close(context, null);
//         });
//   }

//   @override
//   buildSuggestions(BuildContext context) {
//     if (query == '') return Container();
//     return MyFutureBuilder<List<Search>>(
//         future: this.searchBookProvider!.searchProducts(this.query),
//         succesWidget: (List<Search> products) {
//           return ListView.separated(
//               itemCount: products.length,
//               separatorBuilder: (context, index) {
//                 return Divider(height: .1);
//               },
//               itemBuilder: (BuildContext context, int index) {
//                 Search p = products[index];
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(.2),
//                     ),
//                     child: Column(children: [
//                       Row(children: [
//                         buildMatch(query, p.type, context),
//                       ]),
//                       Container(
//                         child: buildMatch(query, p.type, context),
//                       ),
//                     ]),
//                   ),
//                 );
//               });
//         });
//   }
// }

// buildMatch(String query, String found, BuildContext context) {
//   var tabs = found.toLowerCase().split(query.toLowerCase());
//   List<TextSpan> list = [];
//   for (var i = 0; i < tabs.length; i++) {
//     if (i % 2 == 1) {
//       list.add(TextSpan(
//           text: query,
//           style: TextStyle(
//               color: Colors.green, fontWeight: FontWeight.w600, fontSize: 15)));
//     }
//     list.add(TextSpan(text: tabs[i]));
//   }
//   return RichText(
//     text: TextSpan(style: TextStyle(color: Colors.black), children: list),
//   );
// }

//Common wiget

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
