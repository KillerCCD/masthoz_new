import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/config/palette.dart';

import '../../helper_widgets/actions_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Palette.textLineOrBackGroundColor,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: ActionsHelper(
                //botomPadding: 55,
                text: 'Օրվա խոսք',
                fontFamily: 'Grapalat',
                rightPadding: 10.0,
                fontSize: 20,
                laterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Palette.appBarTitleColor,
              ),
              expandedHeight: 73,
              backgroundColor: Palette.textLineOrBackGroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            ),
          ],
        ));
  }
}
