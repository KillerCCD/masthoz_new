import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/palette.dart';
import '../login_sign/login_screen/login_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

///sharing platform
enum Share {
  messenger,
  whatsapp,
  share_system,
  share_instagram,
  share_telegram
}

class SaveShowDialog extends StatefulWidget {
  final bool? isShow;

  const SaveShowDialog({Key? key, this.isShow}) : super(key: key);

  @override
  State<SaveShowDialog> createState() => _SaveShowDialogState();
}

class _SaveShowDialogState extends State<SaveShowDialog> {
  File? file;
  bool videoEnable = false;
  @override
  Widget build(BuildContext context) {
    return widget.isShow == true
        ? AlertDialog(
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
                                          color: Palette
                                              .textLineOrBackGroundColor),
                                    ))),
                          ),
                        )
                      ],
                    ),
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
          )
        : Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 260,
                ),
                child: Container(
                  height: 155,
                  color: Colors.amber,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 152,
                            width: double.infinity,
                            child: Material(
                                child: Container(
                              color: Palette.textLineOrBackGroundColor,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  SizedBox(height: 15.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (
                                              context,
                                            ) =>
                                                SaveShowDialog(
                                                  isShow: true,
                                                ));
                                      },
                                      child: Text(
                                        'Կիսվել',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Divider(
                                      color: Color.fromRGBO(226, 224, 224, 1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                // final urlImage =
                                                //     'https://picsum.photos/200/300/?blur';
                                                // await launchUrl(Uri.parse(
                                                //     'https://https://www.facebook.com/sharer?u=&$urlImage'));
                                                onButtonTap(Share.messenger);
                                                // final url =
                                                //     Uri.parse(urlImage);
                                                // final response =
                                                //     await http.get(url);

                                                // await Share.share(urlImage);
                                              },
                                              child: SvgPicture.asset(
                                                  'assets/images/messenger 2.svg')),
                                          InkWell(
                                            onTap: () async {
                                              onButtonTap(Share.messenger);
                                              // final urlImage =
                                              //     'https://picsum.photos/200/300/?blur';
                                              // await launchUrl(Uri.parse(
                                              //     'https://https://www.facebook.com/sharer?u=&$urlImage'));
                                            },
                                            child: SvgPicture.asset(
                                                'assets/images/whatsapp 2.svg'),
                                          ),
                                          SvgPicture.asset(
                                              'assets/images/gmail 2.svg'),
                                          SvgPicture.asset(
                                              'assets/images/messenger 2.svg'),
                                          SvgPicture.asset(
                                              'assets/images/vk-social-logotype (1) 2.svg'),
                                          SvgPicture.asset(
                                              'assets/images/facebook (1) 4.svg'),
                                          SvgPicture.asset(
                                              'assets/images/twitter (1) 4.svg'),
                                        ],
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }

  Future<void> onButtonTap(Share share) async {
    String msg =
        'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
    String url = 'https://pub.dev/packages/flutter_share_me';

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.messenger:
        response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
        break;

      case Share.whatsapp:
        if (file != null) {
          response = await flutterShareMe.shareToWhatsApp(
              imagePath: file!.path,
              fileType: videoEnable ? FileType.video : FileType.image);
        } else {
          response = await flutterShareMe.shareToWhatsApp(msg: msg);
        }
        break;

      case Share.share_instagram:
        response = await flutterShareMe.shareToInstagram(
            filePath: file!.path,
            fileType: videoEnable ? FileType.video : FileType.image);
        break;
      case Share.share_telegram:
        response = await flutterShareMe.shareToTelegram(msg: msg);
        break;
      case Share.share_system:
        // TODO: Handle this case.
        break;
    }
    debugPrint(response);
  }
}
