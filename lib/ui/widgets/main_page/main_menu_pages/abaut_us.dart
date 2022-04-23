import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/domens/models/book_data/data.dart';
import 'package:mashtoz_flutter/domens/repository/info_data_provider.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:flutter/gestures.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/contact_page.dart';
import '../../../../config/palette.dart';
import '../../helper_widgets/actions_widgets.dart';

class InfoPage extends StatefulWidget {
  final bool isShow;
  const InfoPage({Key? key, required this.isShow}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState(isShow: isShow);
}

class _InfoPageState extends State<InfoPage> {
  final infoDataProvider = InfoDataProvider();
  final bool isShow;

  _InfoPageState({required this.isShow});

  Future<Data>? futureInfoAbautUs;
  Future<Data>? futureInfoDonation;
  @override
  void initState() {
    futureInfoAbautUs = infoDataProvider.getInfoAbaoutUs_Donation(Api.abaoutUs);
    futureInfoDonation =
        infoDataProvider.getInfoAbaoutUs_Donation(Api.donation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isShow
          ? const Color.fromRGBO(117, 99, 111, 1)
          : Color.fromRGBO(226, 224, 224, 1),
      body: SafeArea(
        child: FutureBuilder<Data>(
          future: isShow ? futureInfoAbautUs : futureInfoDonation,
          builder: (context, snapshot) {
            var characters = snapshot.data;
            if (snapshot.hasData) {
              return CustomScrollView(slivers: [
                SliverAppBar(
                  title: ActionsHelper(
                    //botomPadding: 55,
                    text: '${characters?.title}',
                    fontFamily: 'Grapalat',
                    rightPadding: 10.0,
                    fontSize: 20,
                    laterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: isShow
                        ? Palette.textLineOrBackGroundColor
                        : const Color.fromRGBO(117, 99, 111, 1),
                  ),
                  expandedHeight: 73,
                  backgroundColor: isShow
                      ? const Color.fromRGBO(117, 99, 111, 1)
                      : Color.fromRGBO(226, 224, 224, 1),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        isShow
                            ? SizedBox(
                                width: 130.0,
                                height: 130.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: CachedNetworkImage(
                                    imageUrl: "${characters?.image!}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(height: isShow ? 20.0 : 0.0),
                        isShow
                            ? Text('Անուն Ազգանուն',
                                style: TextStyle(
                                    fontFamily: 'GHEAGpalat',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 18,
                                    color: Color.fromRGBO(25, 4, 18, 1)))
                            : Container(),
                        SizedBox(height: isShow ? 20.0 : 0.0),
                        ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(12.0),
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Text(
                              '${characters?.body}',
                              style: TextStyle(
                                  fontFamily: 'GHEAGpalat',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                  fontSize: 14,
                                  color: isShow
                                      ? Palette.textLineOrBackGroundColor
                                      : Color.fromRGBO(51, 51, 51, 1)),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        isShow
                            ? Container(
                                color: Color.fromRGBO(226, 224, 224, 1),
                                height: 100,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                'Հուսով եմ, այս կայքի էջերը օգտակար\n',
                                          ),
                                          TextSpan(
                                            text: 'են լինում Ձեզ։\n',
                                          ),
                                          TextSpan(text: 'Որևէ հարցով, '),
                                          TextSpan(
                                            text: ' գրեցեք ինձ:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            Contact()));
                                              },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    )
                  ]),
                ),
              ]);
            } else {
              return Container(
                child: Center(
                    child: CircularProgressIndicator(
                  color: Palette.main,
                )),
              );
            }
          },
        ),
      ),
    );
  }
}
//  FutureBuilder<Data?>(
//                 future: futureInfo,
//                 builder: (context, snapshot) {
//                   var characters = snapshot.data;

//                   if (snapshot.hasData) {
//                     return Column(
//                       children: [
//                         ListView(
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           padding: EdgeInsets.all(12.0),
//                           physics: NeverScrollableScrollPhysics(),
//                           children: [
//                             Text(
//                               '${characters!.body}',
//                               style: TextStyle(
//                                   fontFamily: 'GHEAGpalat',
//                                   fontWeight: FontWeight.w400,
//                                   letterSpacing: 1.2,
//                                   fontSize: 14,
//                                   color: Palette.textLineOrBackGroundColor),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Container(
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   }
//                 },
//               )
