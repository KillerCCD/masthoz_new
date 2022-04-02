import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/singup_screen/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(
        83,
        66,
        76,
        1,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // const Icon(
                      //   Icons.arrow_back_ios_rounded,
                      //   color: Palette.textOrLine,
                      // ),
                      IconButton(
                        padding: const EdgeInsets.only(right: 20),
                        splashRadius: 0.1,
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Palette.textLineOrBackGroundColor,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Գրանցում',
                            style: TextStyle(
                                fontSize: 27,
                                fontFamily: 'Grapalat',
                                color: Palette.textLineOrBackGroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
