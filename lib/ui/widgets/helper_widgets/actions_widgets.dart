// ignore_for_file: no_logic_in_create_state

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/config/palette.dart';

class ActionsHelper extends StatefulWidget {
  final double? sizeIcon;
  final double? sizeBox;

  final Color? color;

  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;

  final double? laterSpacing;

  final double? topPadding;
  final double? leftPadding;
  final double? rightPadding;
  final double? botomPadding;

  final double? topIcon;
  final double? leftIcon;
  final double? rightIcon;
  final double? botomIcon;

  final String? text;

  final bool? buttonShow;

  final Widget? icon;

  const ActionsHelper({
    Key? key,
    this.icon,
    this.rightPadding = 0.0,
    this.buttonShow = false,
    this.botomPadding = 0,
    this.sizeIcon,
    this.sizeBox,
    this.color,
    this.text = '',
    this.topIcon = 0.0,
    this.leftIcon = 0.0,
    this.botomIcon = 0.0,
    this.rightIcon = 0.0,
    this.topPadding = 0,
    this.leftPadding = 0,
    this.fontSize = 0.0,
    this.fontFamily = '',
    this.laterSpacing = 0,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  State<ActionsHelper> createState() => _ActionsHelperState(
        fontFamily: fontFamily,
        fontSize: fontSize,
        text: text,
        fontWeight: fontWeight,
        topPadding: topPadding,
        laterSpacing: laterSpacing,
        leftPadding: leftPadding,
        rightPadding: rightPadding,
        botomPadding: botomPadding,
        color: color,
        topIcon: topIcon,
        rightIcon: rightIcon,
        leftIcon: leftIcon,
        botomIcon: botomIcon,
        buttonShow: buttonShow!,
        icon: icon,
      );
}

class _ActionsHelperState extends State<ActionsHelper>
    with SingleTickerProviderStateMixin {
  final double? sizeIcon;
  final double? sizeBox;

  final Color? color;

  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;

  final double? laterSpacing;

  final double? topPadding;
  final double? leftPadding;
  final double? rightPadding;
  final double? botomPadding;

  final double? topIcon;
  final double? leftIcon;
  final double? rightIcon;
  final double? botomIcon;

  final String? text;

  final bool? buttonShow;

  final Widget? icon;

  _ActionsHelperState({
    this.icon,
    this.buttonShow = false,
    this.sizeIcon,
    this.sizeBox,
    this.color,
    this.text,
    this.topPadding = 0.0,
    this.rightPadding = 0.0,
    this.leftPadding = 0.0,
    this.botomPadding = 0.0,
    this.fontSize = 0.0,
    this.fontFamily = '',
    this.laterSpacing = 0.0,
    this.topIcon = 0.0,
    this.leftIcon = 0.0,
    this.botomIcon = 0.0,
    this.rightIcon = 0.0,
    this.fontWeight = FontWeight.normal,
  });
  late AnimationController _controller;
  bool iconAcitve = true;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  bool _isDrawerOpen() {
    return _controller.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _controller.status == AnimationStatus.forward;
  }

  void _toggleDrawer() {
    if (_controller.isCompleted) {
      _controller.reverse();
      setState(() {
        iconAcitve = true;
      });
    } else {
      _controller.forward();
      setState(() {
        iconAcitve = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0, end: 0.5 * pi).animate(_controller);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Row(
            children: [
              buttonShow!
                  ? Container(
                      child: IconButton(
                        padding: EdgeInsets.only(
                            top: topPadding!,
                            left: leftPadding!,
                            right: rightPadding!,
                            bottom: botomPadding!),
                        //constraints: BoxConstraints.loose(Size(20, 30)),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color.fromRGBO(122, 108, 115, 1),
                        ),
                        iconSize: sizeIcon,
                        color: Palette.appBarTitleColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      width: 15,
                      height: 30,
                    ),
              Container(
                width: 270,
                padding: EdgeInsets.only(
                    top: text!.length > 20 ? 20.0 : topPadding!,
                    left: leftPadding!,
                    right: rightPadding!,
                    bottom: botomPadding!),
                child: Text(
                  text ?? '',
                  textAlign: TextAlign.start,
                  // softWrap: true,
                  style: TextStyle(
                      letterSpacing: laterSpacing,
                      fontFamily: fontFamily,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 20),
          child: SizedBox(
            height: 120,
            width: 32,
            child: Stack(children: [
              InkWell(
                onTap: _toggleDrawer,
                child: SvgPicture.asset(
                  'assets/images/app_bar_icon_button.svg',

                  color: iconAcitve
                      ? Palette.appBarIconMenuColor
                      : const Color.fromRGBO(122, 108, 115, 1),
                  fit: BoxFit.cover,
                  height: 90,
                  //width: 60,
                  //width: 22,
                ),
              ),
              SizedBox(
                  height: 80,
                  width: 50,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        _toggleDrawer;
                      },
                      child: AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: animation.value.toDouble(),
                            child: InkWell(
                              onTap: _toggleDrawer,
                              child: _isDrawerOpen() || _isDrawerOpening()
                                  ? SvgPicture.asset(
                                      'assets/images/close_bar_icon.svg',
                                      height: 15,
                                      width: 8,
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/asset_bar_icon.svg',
                                      height: 10,
                                      width: 8,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
            ]),
          ),
        ),
      ],
    );
  }

  Widget cont() {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * .3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
            child: const Text("Choose Wisely",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: OutlineButton(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('dadas'),
                    splashColor: Colors.white,
                    highlightedBorderColor: Colors.teal,
                    onPressed: () {
                      Navigator.of(context).pop("Maquina");
                    },
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: OutlineButton(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('dadas'),
                    splashColor: Colors.white,
                    highlightedBorderColor: Colors.teal,
                    onPressed: () {
                      Navigator.of(context).pop("Monarcas");
                    },
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
