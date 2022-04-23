import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/login_screen/login_screen.dart';

import '../../../../config/palette.dart';
import '../../helper_widgets/actions_widgets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.textLineOrBackGroundColor,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: ActionsHelper(
                //botomPadding: 55,
                text: 'Իմ հաշիվը',
                fontFamily: 'Grapalat',
                rightPadding: 10.0,
                fontSize: 20,
                laterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Palette.appBarTitleColor,
                buttonShow: true,
              ),
              expandedHeight: 73,
              backgroundColor: Palette.textLineOrBackGroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Text('Login Screen')),
              ),
            )
          ],
        ));
  }
}
