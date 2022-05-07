import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../login_sign/login_screen/login_screen.dart';

class SaveShowDialog extends StatelessWidget {
  const SaveShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 24.0),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      content: Builder(builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          width: width,
          height: 190,
          child: Column(
            children: [
              Expanded(
                child: Text(
                  'Տվյալ նյութը պահելու \nհամար անհրաժեշտ է \nմուտք գործել',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 25),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Փակել',
                        style: TextStyle(
                            fontFamily: 'GHEAGrapalat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Color.fromRGBO(122, 108, 115, 1)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: Container(
                          color: Palette.main,
                          height: 40,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Մուտք',
                                style: TextStyle(
                                    fontFamily: 'GHEAGrapalat',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                    color: Palette.textLineOrBackGroundColor),
                              ))),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
      contentTextStyle: TextStyle(
          fontFamily: 'GHEAGrapalat',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          color: Color.fromRGBO(97, 109, 135, 1)),
    );
    ;
  }
}
