import 'package:flutter/material.dart';

class Triangle extends CustomPainter {
  Paint? painter;

  Triangle() {
    painter = Paint()
      ..color = const Color.fromRGBO(83, 66, 77, 1)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width * 1 / 2, size.height * 2.5 / 4);
    path.lineTo(size.width * 3 / 9, size.height * 4 / 4);
    path.lineTo(size.width * 5 / 7.5, size.height * 4 / 4);
    path.close();

    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BottomBar extends StatefulWidget {
  final Function()? onPressed;
  final bool? bottomIcons;
  final Widget? path;

  const BottomBar({
    Key? key,
    this.onPressed,
    this.bottomIcons,
    this.path,
  }) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: widget.bottomIcons == true ? widget.path : widget.path,
    );
  }
}
