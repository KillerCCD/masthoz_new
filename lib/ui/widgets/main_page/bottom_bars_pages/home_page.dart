import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/config/palette.dart';

import '../../helper_widgets/actions_widgets.dart';
import '../../helper_widgets/text_widgets.dart';

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
              expandedHeight: 73,
              backgroundColor: Palette.textLineOrBackGroundColor,
              pinned: false,
              floating: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
              flexibleSpace: ActionsHelper(
                leftPadding: 50,
                // botomPadding: 0,
                // topPadding: 30,
                text: 'Օրվա խոսք',
                fontFamily: 'Grapalat',
                fontSize: 20,
                laterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Palette.appBarTitleColor,
              ),
            ),
          ],
        ));
  }
}
