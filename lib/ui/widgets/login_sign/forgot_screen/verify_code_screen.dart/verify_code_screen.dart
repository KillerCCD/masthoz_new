import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String userEmail;

  const VerifyCodeScreen({Key? key, this.userEmail = ''}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() =>
      _VerifyCodeScreenState(userEmail: userEmail);
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  String userEmail;

  var smsCode;
  bool hasError = false;

  String currentText = "";

  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  _VerifyCodeScreenState({required this.userEmail});
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
                      'Մուտքագրեք կոդը',
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
                'Մուտքագրեք էլ. փոստին ուղարկված \nեցանիշ թիվը',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Grapalat',
                    color: Palette.textLineOrBackGroundColor),
              ),
              SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: PinCodeTextField(
                          appContext: context,
                          textStyle: TextStyle(
                              color: Palette.textLineOrBackGroundColor),
                          pinTheme: PinTheme(
                              borderRadius: BorderRadius.zero,
                              activeFillColor: Palette.whenTapedButton,
                              inactiveColor: Palette.disable,
                              inactiveFillColor: Colors.green,
                              selectedFillColor: Colors.deepPurple,
                              selectedColor: Palette.whenTapedButton,
                              activeColor: Palette.textLineOrBackGroundColor),
                          cursorColor: Palette.main,
                          length: 6,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          animationDuration: Duration(milliseconds: 300),
                          controller: textController,
                          errorAnimationController: errorController,
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          validator: (v) {
                            if (v!.length < 3) {
                              return "I'm from validator";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Align(
                        child: SizedBox(
                          width: 47,
                          child: RawMaterialButton(
                            onPressed: () {
                              _formKey.currentState!.validate();
                              if (currentText.length != 6) {
                                errorController!.add(ErrorAnimationType
                                    .shake); // Triggering error shake animation
                                setState(() => hasError = true);
                              } else {
                                errorController!.add(ErrorAnimationType
                                    .shake); // Triggering error shake animation
                                setState(() => hasError = false);
                              }
                            },
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(
                                  width: 47,
                                  height: 50,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/login_button.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
