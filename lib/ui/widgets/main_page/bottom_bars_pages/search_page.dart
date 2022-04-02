import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/text_widgets.dart';

import '../../../../config/palette.dart';
import '../../helper_widgets/actions_widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Palette.searchBackGroundColor,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 73,
              backgroundColor: Palette.searchBackGroundColor,
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
                text: 'Որոնել',
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
