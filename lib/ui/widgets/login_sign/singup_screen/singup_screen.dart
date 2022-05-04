import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/ui/widgets/buttons/facebook_gmail_buttons.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/singup_screen/signup_form.dart';

import '../login_screen/login_screen.dart';

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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20.0, top: 39, left: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              padding: const EdgeInsets.only(top: 3.5),
                              splashRadius: 0.1,
                              iconSize: 23,
                              alignment: Alignment.topCenter,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Padding(
                                padding:
                                    EdgeInsets.only(right: double.infinity),
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Palette.textLineOrBackGroundColor,
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 89,
                            // ),
                            Expanded(
                              child: Container(
                                height: 48,
                                padding: EdgeInsets.only(right: 50),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: const Text(
                                    'Գրանցում',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'GHEAGrapalat',
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Palette.textLineOrBackGroundColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       right: 20.0, left: 20.0, top: 39),
                        //   child: Row(
                        //     children: [
                        //       // const Icon(
                        //       //   Icons.arrow_back_ios_rounded,
                        //       //   color: Palette.textOrLine,
                        //       // ),
                        //       IconButton(
                        //         padding: const EdgeInsets.only(right: 20),
                        //         splashRadius: 0.1,
                        //         iconSize: 13,
                        //         onPressed: () {
                        //           Navigator.pop(context, false);
                        //         },
                        //         icon: const Icon(
                        //           Icons.arrow_back_ios_rounded,
                        //           color: Palette.textLineOrBackGroundColor,
                        //         ),
                        //       ),
                        //       const Center(
                        //         //   flex: 1,
                        //         widthFactor: 2.5,
                        //         child: Text(
                        //           'Գրանցում',
                        //           style: TextStyle(
                        //               fontSize: 20,
                        //               fontFamily: 'GHEAGrapalat',
                        //               color: Palette.textLineOrBackGroundColor),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SignupForm(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 55.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ComplexButton2()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
