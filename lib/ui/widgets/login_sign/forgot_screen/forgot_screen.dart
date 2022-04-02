import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/config/palette.dart';

import 'forgot_form.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(
          83,
          66,
          76,
          1,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(right: 20),
                      splashRadius: 0.1,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Palette.textLineOrBackGroundColor,
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    const Text(
                      'Մոռացել եք\n գաղտնաբառը',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 27,
                          fontFamily: 'Grapalat',
                          color: Palette.textLineOrBackGroundColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'Մուտքագրեք ձեր հաշվում լրացված\n էլեկտրոնային փոստի հասցեն',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Grapalat',
                    color: Palette.textLineOrBackGroundColor),
              ),
              const ForgotForm(),
            ],
          ),
        ),
      ),
    );
  }
}
