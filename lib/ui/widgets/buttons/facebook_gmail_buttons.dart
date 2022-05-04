import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/login_screen/login_screen.dart';

import '../login_sign/singup_screen/singup_screen.dart';

class CoupleButtons extends StatelessWidget {
  const CoupleButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
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

class ComplexButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60.0,
            color: Palette.barColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SignUpButton(),
                  Expanded(child: CoupleButtons()),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ComplexButton2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60.0,
            color: Palette.barColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SignUpButton2(),
                  Expanded(child: CoupleButtons()),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('grancvel hima');
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SignupScreen()));
      },
      child: const Text(
        'Գրանցվել հիմա',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'GHEAGrapalat',
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      style: TextButton.styleFrom(padding: const EdgeInsets.only(right: 40)),
    );
  }
}

class SignUpButton2 extends StatelessWidget {
  const SignUpButton2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('grancvel hima');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: const Text(
        'Մուտք գործել',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'GHEAGrapalat',
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      style: TextButton.styleFrom(padding: const EdgeInsets.only(right: 40)),
    );
  }
}
