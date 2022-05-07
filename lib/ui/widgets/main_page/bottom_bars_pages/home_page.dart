import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';
import 'package:mashtoz_flutter/domens/models/book_data/content_list.dart';

import 'package:mashtoz_flutter/ui/widgets/helper_widgets/menuShow.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/books_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.textLineOrBackGroundColor,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Օրվա խոսք',
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontFamily: 'GHEAGrapalat',
                        fontWeight: FontWeight.bold,
                        color: Palette.appBarTitleColor),
                  ),
                ),
                expandedHeight: 53,
                backgroundColor: Palette.textLineOrBackGroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
                actions: [
                  MenuShow(),
                ],
              ),
              // // SliverToBoxAdapter(
              // //   child: Container(
              // //     width: MediaQuery.of(context).size.width,
              // //     height: MediaQuery.of(context).size.height,
              // //     child: SingleChildScrollView(
              // //         child: Column(
              // //       children: [
              // //         Container(
              // //             padding: EdgeInsets.only(left: 5.0),
              // //             height: 50,
              // //             width: MediaQuery.of(context).size.width,
              // //             child: Row(
              // //               mainAxisAlignment: MainAxisAlignment.start,
              // //               children: [
              // //                 Container(
              // //                   decoration: BoxDecoration(
              // //                       color: Palette.whenTapedButton,
              // //                       boxShadow: [
              // //                         BoxShadow(
              // //                           color: Color.fromRGBO(31, 31, 31, 0.5),
              // //                           blurRadius: 1.0,
              // //                           spreadRadius: 0.0,
              // //                           offset: Offset(-1.5, 3),
              // //                         ),
              // //                       ]),
              // //                   width: 50,
              // //                   height: 44,
              // //                   child: Align(
              // //                       alignment: Alignment.center,
              // //                       child: Text('25')),
              // //                 ),
              // //                 SizedBox(width: 17),
              // //                 Expanded(
              // //                   child: Container(
              // //                     decoration: BoxDecoration(
              // //                         color: Color.fromRGBO(113, 141, 156, 1),
              // //                         boxShadow: [
              // //                           BoxShadow(
              // //                             color:
              // //                                 Color.fromRGBO(31, 31, 31, 0.5),
              // //                             blurRadius: 1.0,
              // //                             spreadRadius: 0.0,
              // //                             offset: Offset(-1.5, 3),
              // //                           ),
              // //                         ]),
              // //                     width: MediaQuery.of(context).size.width,
              // //                     height: 44,
              // //                     child: Padding(
              // //                       padding: const EdgeInsets.only(
              // //                           top: 12.0, left: 12.0),
              // //                       child: Text(
              // //                         'Օրվա խոսք',
              // //                         style: TextStyle(
              // //                             fontFamily: 'GHEAGrapalat',
              // //                             fontSize: 14.0,
              // //                             fontWeight: FontWeight.w400,
              // //                             color: Colors.white),
              // //                         textAlign: TextAlign.start,
              // //                       ),
              // //                     ),
              // //                   ),
              // //                 )
              // //               ],
              // //             )),
              // //         SizedBox(height: 14),
              // //         Container(
              // //           color: Color.fromRGBO(246, 246, 246, 1),
              // //           height: 380,
              // //           width: double.infinity,
              // //           child: Stack(
              // //             children: [
              // //               Container(
              // //                   color: Color.fromRGBO(246, 246, 246, 1),
              // //                   width: double.infinity,
              // //                   padding: EdgeInsets.all(16.0),
              // //                   height: 300,
              // //                   child: Scrollbar(
              // //                       thickness: 1.5,
              // //                       radius: const Radius.circular(12),
              // //                       isAlwaysShown: false,
              // //                       showTrackOnHover: true,
              // //                       child: Center(
              // //                           child: ListView(
              // //                         children: [
              // //                           Text(
              // //                               'Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: Կյանքում ոչ անհետ ու անհետևանք չի անցնում։ Եթե մի օր մի տեղ մի ծառ ես տնկել, տարիներ հետո դու էլ չէ, ինչ-որ մեկը պիտի նստի նրա շվաքին։ Իսկ թե մի օր մի տեղ մի ճյուղ ես կոտրել, աշխարհի երեսից մի բոռ շվաք, մի քիչ սոսափ կպակասի ու կխաթարվի տիեզերքի հավասարակշռությունը։ Կյանքում ոչինչ անհետ ու անհետևանք չի անցնում: ')
              // //                         ],
              // //                       )))),
              // //               Positioned.fill(
              // //                   bottom: 50,
              // //                   child: Align(
              // //                     alignment: Alignment.bottomCenter,
              // //                     child: Padding(
              // //                       padding: const EdgeInsets.only(
              // //                           right: 16.0, left: 16.0),
              // //                       child: Divider(
              // //                         thickness: 1,
              // //                       ),
              // //                     ),
              // //                   )),
              // //               Positioned.fill(
              // //                   child: Align(
              // //                       alignment: Alignment.bottomRight,
              // //                       child: Container(
              // //                           padding: EdgeInsets.only(
              // //                               left: 16.0, right: 16.0),
              // //                           height: 50,
              // //                           child: Align(
              // //                             alignment: Alignment.centerRight,
              // //                             child: Text(
              // //                               'Սոս Սարգսյան',
              // //                               textAlign: TextAlign.center,
              // //                             ),
              // //                           )))),
              // //             ],
              // //           ),
              // //         ),
              // //         Container(
              // //             height: 400,
              // //             child: Center(
              // //                 child: ListView.builder(
              // //                     itemCount: 2,
              // //                     itemBuilder: (context, index) {
              // //                       return Column(
              // //                         children: [
              // //                           BookCard(
              // //                             isOdd: false,
              // //                             categorys: BookCategory(
              // //                                 categoryTitle: 'suka',
              // //                                 id: 1,
              // //                                 title: 'dadasion',
              // //                                 type: 'libraries'),
              // //                             book: Content(
              // //                               videoLink: null,
              // //                               content: null,
              // //                               body: '',
              // //                               id: 1,
              // //                               image: 'https://picsum.photos/200',
              // //                               title: 'Davidi Verchi xosqy',
              // //                               author: 'Davit Mcarenc',
              // //                               explanation: '',
              // //                             ),
              // //                           ),
              // //                           SizedBox(height: 30.0),
              // //                         ],
              // //                       );
              // //                     })))
              // //       ],
              // //     )),
              // //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
//!! inkwell
//  InkWell(
//                       onTap: () {
//                         setState(() {
//                           _toggleDrawer();

//                         });
//                         showGeneralDialog(
//                             context: context,
//                             barrierDismissible: true,
//                             barrierColor: Colors.black.withOpacity(0.1),
//                             transitionDuration: Duration(microseconds: 500),
//                             barrierLabel:
//                                 MaterialLocalizations.of(context).dialogLabel,
//                             pageBuilder: (
//                               context,
//                               _,
//                               __,
//                             ) {
//                               return Column(
//                                 children: [
//                                   Container(
//                                       color: Colors.red,
//                                       width:
//                                           MediaQuery.of(context).size.width,
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               1.08,
//                                       child: Scaffold(
//                                         body: AppBar(
//                                           title: SvgPicture.asset(
//                                               'assets/images/mashtoz_org.svg'),
//                                           leading: Container(),
//                                           toolbarHeight: 63,
//                                           actions: [
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   right: 20.0),
//                                               child: InkWell(
//                                                 onTap: _toggleDrawer,
//                                                 child: SizedBox(
//                                                   height: 120,
//                                                   width: 30,
//                                                   child: Stack(children: [
//                                                     InkWell(
//                                                       onTap: () {
//                                                         // print('notWorking');
//                                                         _toggleDrawer();

//                                                         Navigator.pop(
//                                                             context);
//                                                       },
//                                                       child: SvgPicture.asset(
//                                                         'assets/images/app_bar_icon_button.svg',

//                                                             : const Color
//                                                                     .fromRGBO(
//                                                                 122,
//                                                                 108,
//                                                                 115,
//                                                                 1),
//                                                         fit: BoxFit.cover,
//                                                         height: 90,
//                                                         //width: 60,
//                                                         //width: 22,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 80,
//                                                       width: 50,
//                                                       child: Center(
//                                                         child:
//                                                             AnimatedBuilder(
//                                                           animation:
//                                                               animation,
//                                                           builder: (context,
//                                                               child) {
//                                                             return InkWell(
//                                                               onTap: () {
//                                                                 _toggleDrawer();
//                                                                 Navigator.pop(
//                                                                     context);
//                                                               },
//                                                               child: Transform
//                                                                   .rotate(
//                                                                 angle: animation
//                                                                     .value
//                                                                     .toDouble(),
//                                                                 child: _isDrawerOpen() ||
//                                                                         _isDrawerOpening()
//                                                                     ? SvgPicture
//                                                                         .asset(
//                                                                         'assets/images/close_bar_icon.svg',
//                                                                         height:
//                                                                             15,
//                                                                         width:
//                                                                             8,
//                                                                       )
//                                                                     : SvgPicture
//                                                                         .asset(
//                                                                         'assets/images/asset_bar_icon.svg',
//                                                                         height:
//                                                                             10,
//                                                                         width:
//                                                                             8,
//                                                                       ),
//                                                               ),
//                                                             );
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ]),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )),
//                                 ],
//                               );
//                             },
//                             transitionBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               return SlideTransition(
//                                 position: CurvedAnimation(
//                                   parent: animation,
//                                   curve: Curves.easeInOutCubic,
//                                 ).drive(
//                                   Tween<Offset>(
//                                       begin: Offset(0, -1.0),
//                                       end: Offset.zero),
//                                 ),
//                                 child: child,
//                               );
//                             });
//                       },
//                       child: SvgPicture.asset(
//                         'assets/images/app_bar_icon_button.svg',

//                         color: iconAcitve
//                             ? Palette.appBarIconMenuColor
//                             : const Color.fromRGBO(122, 108, 115, 1),
//                         fit: BoxFit.cover,
//                         height: 90,
//                         //width: 60,
//                         //width: 22,
//                       ),
//                     ),                                                         color: iconAcitve
//                                                             ? Palette
//                                                                 .appBarIconMenuColor
