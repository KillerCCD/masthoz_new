import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              children: const [
                SizedBox(height: 30),
                SizedBox(
                  width: 142,
                  height: 98,
                  child: Image(
                    image: AssetImage("assets/images/mashtoz_org.png"),
                    fit: BoxFit.cover,
                  ),
                ),

                LoginForm(),

                // TextButton(onPressed: () => '', child: Text('cik'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
