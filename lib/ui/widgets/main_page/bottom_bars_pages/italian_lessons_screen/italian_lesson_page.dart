import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/autio_librar_test.dart';

import '../../../../../config/palette.dart';
import '../../../helper_widgets/actions_widgets.dart';
import 'dart:math' as math;

class ItalianPage extends StatefulWidget {
  const ItalianPage({Key? key}) : super(key: key);

  @override
  State<ItalianPage> createState() => _ItalianPageState();
}

class _ItalianPageState extends State<ItalianPage>
    with TickerProviderStateMixin {
  final bookDataProvider = BookDataProvider();
  Future<List<Lessons>>? lessonFuture;
  List<Lessons> lessons = [];

  late Animation sizeRibbonAnimation, sizeNumberAnimation, sizeImageAnimation;

  late AnimationController _controller;
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late final TabController _tabController;
  final int _tabLength = 2;
  final bool showPage = false;
  bool isOdd = false;
  @override
  void initState() {
    lessonFuture = bookDataProvider.getLessons();
    _tabController = TabController(length: _tabLength, vsync: this);
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    sizeRibbonAnimation =
        Tween<double>(begin: 0.0, end: 304.0).animate(_controller);
    sizeNumberAnimation =
        Tween<double>(begin: 0.0, end: 259).animate(_controller);
    sizeImageAnimation =
        Tween<double>(begin: -220.0, end: 16.0).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
    _loadItems();
  }

  Future<void> _loadItems() async {
    List result = await bookDataProvider.getLessons();
    for (var item in result) {
      await Future.delayed(const Duration(milliseconds: 200));

      lessons.add(item);

      _listKey.currentState?.insertItem(lessons.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLength,
      child: Scaffold(
          backgroundColor: Palette.textLineOrBackGroundColor,
          extendBodyBehindAppBar: true,
          body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CustomScrollView(
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
                        leftPadding: 50,
                        // botomPadding: 0,
                        // topPadding: 30,
                        text: 'Իտալերենի դասեր',
                        fontFamily: 'Grapalat',
                        fontSize: 20,
                        laterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: Palette.appBarTitleColor,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        FutureBuilder<List<Lessons>>(
                          future: lessonFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var listsLesson = snapshot.data;
                              return AnimatedList(
                                key: _listKey,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index,
                                    animation) {
                                  final Lessons italianLesson =
                                      listsLesson![index];

                                  if (index % 2 != 0) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0),
                                        end: const Offset(0, 0),
                                      ).animate(CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.bounceIn,
                                          reverseCurve: Curves.bounceOut)),
                                      child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: Container(
                                            child: ITLesson(
                                              isOdd: true,
                                              italianLesson: italianLesson,
                                            ),
                                          )),
                                    );
                                  } else {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0),
                                        end: const Offset(0, 0),
                                      ).animate(CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.bounceIn,
                                          reverseCurve: Curves.bounceOut)),
                                      child: Container(
                                        child: ITLesson(
                                          isOdd: false,
                                          italianLesson: italianLesson,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                initialItemCount: snapshot.data!.length,
                              );
                            } else {
                              return Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                      child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: Palette.main,
                                  )),
                                ],
                              ));
                            }
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
                //  AudioLibrary(),
              ])),
    );
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          // handle 0 position
          print(_tabController.index);
          break;
        case 1:
          print(_tabController.index);
          // handle 1 position

          break;
      }
    }
  }
}

class ITLesson extends StatefulWidget {
  const ITLesson({Key? key, required this.isOdd, required this.italianLesson})
      : super(key: key);

  final bool isOdd;
  final Lessons italianLesson;

  @override
  _ItalianLessonState createState() =>
      // ignore: no_logic_in_create_state
      _ItalianLessonState(isOdd: isOdd, italianLesson: italianLesson);
}

class _ItalianLessonState extends State<ITLesson>
    with TickerProviderStateMixin {
  _ItalianLessonState({required this.italianLesson, required this.isOdd});
  final bool showPage = false;
  final bool isOdd;
  final Lessons italianLesson;
  bool selected = true;

  late Animation sizeRibbonAnimation, sizeNumberAnimation, sizeImageAnimation;

  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    sizeRibbonAnimation =
        Tween<double>(begin: 0.0, end: 304.0).animate(_controller);
    sizeNumberAnimation =
        Tween<double>(begin: 0.0, end: 259).animate(_controller);
    sizeImageAnimation =
        Tween<double>(begin: -220.0, end: 16.0).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
          width: 304,
          height: 168,
          child: Stack(children: <Widget>[
            Positioned(
                top: 36,
                left: 0,
                child: SizedBox(
                    width: 304.0,
                    height: 46,
                    child: Stack(children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: sizeRibbonAnimation.value,
                            height: 46,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(84, 112, 126, 1),
                            )),
                      ),
                      Positioned(
                        top: 13.5,
                        left: sizeNumberAnimation.value,
                        child: isOdd
                            ? Transform(
                                transform: Matrix4.rotationY(math.pi),
                                alignment: Alignment.center,
                                child: Text(
                                  italianLesson.number!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'GHEA Grapalat',
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ))
                            : Text(
                                italianLesson.number!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GHEA Grapalat',
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                      ),
                    ]))),
            Positioned(
                top: 0,
                left: sizeImageAnimation.value,
                child: SizedBox(
                  width: 220,
                  height: 118,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 220,
                            height: 118,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: const Color.fromRGBO(25, 4, 18, 1),
                                width: 1,
                              ),
                            ))),
                    Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          width: 212,
                          height: 110,
                          child: CachedNetworkImage(
                            imageUrl: italianLesson.image!,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ]),
                )),
            Positioned(
                top: 128,
                left: 16,
                child: isOdd
                    ? Transform(
                        transform: Matrix4.rotationY(math.pi),
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          opacity: _controller.isCompleted ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 100),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              italianLesson.title!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(84, 112, 126, 1),
                                  fontFamily: 'GHEA Grapalat',
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6),
                            ),
                          ),
                        ))
                    : AnimatedOpacity(
                        opacity: _controller.isCompleted ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 100),
                        child: InkWell(
                          onTap: () {
                            print('cik');
                          },
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              italianLesson.title!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(84, 112, 126, 1),
                                  fontFamily: 'GHEA Grapalat',
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6),
                            ),
                          ),
                        ),
                      )),
          ])),
    );
  }
}
