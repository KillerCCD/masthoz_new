import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoupleButtons extends StatelessWidget {
  const CoupleButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 85,
        child: Row(
          children: [
            Ink(
              child: InkWell(
                onTap: () {
                  print('gmail taped');
                },
                child: SizedBox(
                  child: SvgPicture.asset('assets/images/gmail.svg'),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Ink(
              child: InkWell(
                onTap: () {
                  print('facebook taped');
                },
                child: SvgPicture.asset('assets/images/Facebook.svg'),
              ),
            ),
          ],
        ));
  }
}
