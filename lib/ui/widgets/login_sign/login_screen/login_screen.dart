import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/ui/widgets/buttons/facebook_gmail_buttons.dart';

import '../../../../config/palette.dart';
import '../singup_screen/singup_screen.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
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
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0),
                          child: Column(
                            children: const [
                              SizedBox(height: 30),
                              Center(
                                child: SizedBox(
                                  width: 142,
                                  height: 98,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/mashtoz_org.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              LoginForm(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 55.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ComplexButton()),
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
