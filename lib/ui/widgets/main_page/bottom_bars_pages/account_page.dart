import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';
import 'package:mashtoz_flutter/globals.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/login_screen/login_screen.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../config/palette.dart';
import '../../../../domens/models/book_data/by_caracters_data.dart';
import '../../../../domens/repository/book_data_provdier.dart';
import '../../helper_widgets/actions_widgets.dart';
import '../../helper_widgets/menuShow.dart';

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
              flexibleSpace: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    top: 23.0,
                  ),
                  child: Container(
                    height: 73,
                    padding: EdgeInsets.only(top: 18),
                    child: Text(
                      'Իմ հաշիվը',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                          fontFamily: 'GHEAGrapalat',
                          fontWeight: FontWeight.w700,
                          color: Palette.appBarTitleColor),
                    ),
                  ),
                ),
              ),
              leading: SizedBox(
                width: 8,
                height: 14,
                child: SvgPicture.asset(
                  'assets/images/Favorite_2 2.svg',
                  fit: BoxFit.none,
                ),
              ),
              expandedHeight: 73,
              backgroundColor: Palette.textLineOrBackGroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: MenuShow(),
                ),
              ],
            ),
            SliverFillRemaining(
              child: DelegateChild(),
            )
          ],
        ));
  }
}

class DelegateChild extends StatefulWidget {
  DelegateChild({
    Key? key,
  }) : super(key: key);

  @override
  State<DelegateChild> createState() => _DelegateChildState();
}

class _DelegateChildState extends State<DelegateChild>
    with SingleTickerProviderStateMixin {
  final userDataProvider = UserDataProvider();

  Future<List<dynamic>?>? favoriteFuture;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: listAccountElements.length,
        vsync: this,
        initialIndex: 0,
        animationDuration: Duration.zero);
    favoriteFuture = userDataProvider.getFavorites();

    super.initState();
  }

  Widget buildData() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          SizedBox(height: 52),
          FutureBuilder<List<dynamic>?>(
              future: favoriteFuture,
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      child: Center(
                          child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Palette.main,
                  )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          textColor: Color.fromRGBO(84, 112, 126, 1),
                          title: Text('${data?[index].title}'),
                          leading: Text(
                            '0${index}',
                            style: TextStyle(color: Palette.main),
                          ),
                          onTap: () {},
                          contentPadding: EdgeInsets.only(right: 10.0),
                        );
                      },
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: listAccountElements.length,
      child: Scaffold(
        backgroundColor: Palette.textLineOrBackGroundColor,
        appBar: PreferredSize(
          preferredSize: Size(18.0, 50.0),
          child: Container(
            color: Color.fromRGBO(246, 246, 246, 1),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TabBar(
                  indicatorWeight: 2,
                  unselectedLabelColor: const Color.fromRGBO(122, 108, 115, 1),
                  labelColor: const Color.fromRGBO(251, 196, 102, 1),
                  indicatorColor: Colors.amber,
                  indicator: MaterialIndicator(
                    color: Colors.amber,
                    height: 2,
                    topLeftRadius: 0,
                    topRightRadius: 0,
                    bottomLeftRadius: 5,
                    bottomRightRadius: 5,
                    tabPosition: TabPosition.top,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  controller: _tabController,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 15),
                  onTap: (index) {
                    // setState(() {
                    //   characters
                    //           .toString()
                    //           .toLowerCase()
                    //           .contains(listAccountElements.elementAt(index))
                    //       ? audioLibraryByCharacters =
                    //           bookDataProvider.getDataByCharacters(
                    //               Api.audioLibrariesByCharacters(
                    //                   listAccountElements.elementAt(index)))
                    //       : null;
                    // });
                  },
                  tabs: listAccountElements.map((tabName) {
                    return Tab(
                      child: Text(
                        tabName,
                        style: TextStyle(
                          fontFamily: 'GHEABrapalat',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          color: listAccountElements
                                  .toString()
                                  .toLowerCase()
                                  .contains(tabName.toLowerCase())
                              ? null
                              : Color.fromRGBO(186, 166, 177, 1),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ),
        ),
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: listAccountElements
                .map(
                  (e) => listAccountElements
                          .toString()
                          .toLowerCase()
                          .contains(e.toLowerCase())
                      ? buildData()
                      : Container(
                          child: Center(
                            child: Text('Empty data'),
                          ),
                        ),
                )
                .toList()),

        //     ))
      ),
    );
  }
}

var listAccountElements = [
  'Գրադարան',
  'Հանրագիտարան',
  'Իտալերենի դասեր',
  'Համաբարբառ',
  'Ձայնադարան',
  'Պատկերադարան'
];
