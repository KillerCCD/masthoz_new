import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../../domens/models/book.dart';



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
