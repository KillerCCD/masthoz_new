import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../config/palette.dart';
import '../../../../../domens/fake_italian_lesson.dart';
import '../../../../../domens/models/book.dart';
import '../../../helper_widgets/actions_widgets.dart';
import 'dart:math' as math;
import 'ialian_lesson_animation.dart';

class ItalianPage extends StatefulWidget {
  const ItalianPage({Key? key}) : super(key: key);

  @override
  State<ItalianPage> createState() => _ItalianPageState();
}

class _ItalianPageState extends State<ItalianPage> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  List<IalianLesson> lessons = [];
  final itali = italianLessons;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    for (var item in itali) {
      await Future.delayed(const Duration(milliseconds: 500));

      lessons.add(item);

      _listKey.currentState?.insertItem(lessons.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.textLineOrBackGroundColor,
        extendBodyBehindAppBar: true,
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
            SliverPadding(
              padding: EdgeInsets.all(15.0),
              sliver: SliverAnimatedList(
                key: _listKey,
                itemBuilder: (BuildContext context, int index, animation) {
                  final IalianLesson italianLesson = lessons[index];

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
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ITLesson(
                          isOdd: false,
                          italianLesson: italianLesson,
                        ),
                      ),
                    );
                  }
                },
                initialItemCount: lessons.length,
              ),
            ),
          ],
        ));
  }
}

class CreateItem extends StatefulWidget {
  const CreateItem({Key? key}) : super(key: key);

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  List<IalianLesson> lessons = [];
  final itali = italianLessons;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    for (var item in itali) {
      await Future.delayed(const Duration(milliseconds: 500));

      lessons.add(item);

      _listKey.currentState?.insertItem(lessons.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 73,
            backgroundColor: Colors.white,
            pinned: false,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            flexibleSpace: Text('Italian daser'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverAnimatedList(
              key: _listKey,
              itemBuilder: (BuildContext context, int index, animation) {
                final IalianLesson italianLesson = lessons[index];

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
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
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
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ITLesson(
                        isOdd: false,
                        italianLesson: italianLesson,
                      ),
                    ),
                  );
                }
              },
              initialItemCount: lessons.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ITLesson extends StatefulWidget {
  final IalianLesson italianLesson;
  final bool isOdd;
  const ITLesson({Key? key, required this.isOdd, required this.italianLesson})
      : super(key: key);

  @override
  _ItalianLessonState createState() =>
      // ignore: no_logic_in_create_state
      _ItalianLessonState(isOdd: isOdd, italianLesson: italianLesson);
}

class _ItalianLessonState extends State<ITLesson>
    with TickerProviderStateMixin {
  final IalianLesson italianLesson;
  final bool isOdd;

  _ItalianLessonState({required this.italianLesson, required this.isOdd});

  late AnimationController _controller;
  late Animation sizeRibbonAnimation, sizeNumberAnimation, sizeImageAnimation;
  bool selected = true;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                                italianLesson.number,
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
                              italianLesson.number,
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
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/Rectangle3789.png'),
                                fit: BoxFit.fitWidth),
                          ))),
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
                        child: Text(
                          italianLesson.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Color.fromRGBO(84, 112, 126, 1),
                              fontFamily: 'GHEA Grapalat',
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.6),
                        ),
                      ))
                  : AnimatedOpacity(
                      opacity: _controller.isCompleted ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 100),
                      child: InkWell(
                        onTap: () {
                          print('cik');
                        },
                        child: Text(
                          italianLesson.title,
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
                    )),
        ]));
  }
}
