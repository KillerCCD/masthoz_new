import 'package:flutter/material.dart';

class TextHelper extends StatelessWidget {
  final double? fontSize;
  final String? fontFamily;
  final double? laterSpacing;
  final FontWeight? fontWeight;
  final double? bottomPadding;
  final String? text;
  final Color? color;
  final TextAlign? textAlign;
  final int? index;
  const TextHelper(
      {Key? key,
      this.index,
      this.text = '',
      this.bottomPadding = 0,
      this.fontSize = 0,
      this.fontFamily = '',
      this.laterSpacing = 0,
      this.fontWeight = FontWeight.normal,
      this.textAlign,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 0),
      child: Text(
        text ?? '',
        textAlign: textAlign,
        style: TextStyle(
            letterSpacing: laterSpacing,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color),
      ),
    );
  }
}
