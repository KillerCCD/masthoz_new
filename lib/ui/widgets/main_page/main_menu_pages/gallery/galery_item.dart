import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/models/book_data/gallery_data.dart'
    as Gallery;

import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/menuShow.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/size_config.dart';
import 'package:photo_view/photo_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../../domens/models/book_data/gallery_data.dart';

class GalleryItem extends StatefulWidget {
  const GalleryItem({Key? key}) : super(key: key);

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  bool isExpanded = false;
  //void open(BuildContext context, final int index) {
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => GalleryPhotoViewWrapper(
  //       galleryItems: galleryItems,
  //       backgroundDecoration: const BoxDecoration(
  //         color: Color.fromRGBO(31, 31, 31, 0.9),
  //       ),
  //       initialIndex: index,
  //     ),
  //   ),
  // );
  //}

  Future<List<dynamic>>? galleryFuture;
  final bookDataProvider = BookDataProvider();

  @override
  void initState() {
    galleryFuture = bookDataProvider.fetchGalleryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            title: Text(
              'Պատկերադարան',
              style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1,
                  fontFamily: 'GHEAGrapalat',
                  fontWeight: FontWeight.w700,
                  color: Palette.appBarTitleColor),
            ),
            pinned: false,
            floating: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Palette.appBarTitleColor,
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
            child: SingleChildScrollView(
              child: FutureBuilder<List<dynamic>>(
                future: galleryFuture,
                builder: (context, snapshot) {
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
                      var data = snapshot.data;

                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            dynamic newData = data?[index];
                            dynamic galery = newData[1];
                            print(galery.runtimeType);
                            return ExpansionTile(
                              title: Container(
                                child: Text(
                                  '${newData[0]}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GHEAGrapalat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                      color: Color.fromRGBO(113, 141, 156, 1)),
                                ),
                              ),
                              onExpansionChanged: (bool expandint) =>
                                  setState(() => this.isExpanded = expandint),
                              leading:
                                  SvgPicture.asset('assets/images/line24.svg'),
                              controlAffinity: ListTileControlAffinity.leading,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: (galery is Gallery.Gallery)
                                      ? galery.images?.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => GalleryView(
                                                  url: (galery
                                                          is Gallery.Gallery)
                                                      ? galery
                                                          .images![index].img
                                                      : galery,
                                                  imagesUrl: (galery
                                                          is Gallery.Gallery)
                                                      ? galery.images
                                                      : [],
                                                  currentIndex: index,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            child: (galery is Gallery.Gallery)
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        '${galery.images?[index].img}')
                                                : Text(
                                                    '$galery',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                          ),
                                        ));
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20.0,
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ),
          )

          // SliverFillRemaining(
          //     child: GridView.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 20.0,
          //   ),
          //   shrinkWrap: true,
          //   scrollDirection: Axis.vertical,
          //   itemCount: galleryItems.length,
          //   itemBuilder: (context, index) {
          //     Gellerys gallery = galleryItems[index];
          //     print(gallery.resource);
          //     // return Text('data');
          //     return GalleryExampleItemThumbnail(
          //       galleryExampleItem: galleryItems[index],
          //       onTap: () {
          //         open(context, index);
          //       },
          //     );
          //   },
          // )),

          //       ],
          //     ),
          //   );
          // }
        ]));
  }
}

class GalleryView extends StatefulWidget {
  final String url;

  final List<Gallery.Image>? imagesUrl;
  final int currentIndex;

  const GalleryView({
    Key? key,
    required this.url,
    required this.imagesUrl,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  int? _currnetInex;
  bool isShowCanc = false;
  bool isShowPlay = false;
  bool isShowFullScreen = false;

  CarouselController? _pageController;

  @override
  void initState() {
    _currnetInex = widget.currentIndex;
    _pageController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          width: 0.1,
          height: 0.1,
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isShowCanc = false;
                  isShowFullScreen = false;
                  isShowPlay = !isShowPlay;
                });
              },
              icon: SvgPicture.asset(
                'assets/images/Play 1.svg',
                color: isShowPlay ? Palette.whenTapedButton : null,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isShowCanc = false;
                  isShowFullScreen = !isShowFullScreen;
                  isShowPlay = false;
                });
              },
              icon: SvgPicture.asset(
                'assets/images/Full screen 1.svg',
                color: isShowFullScreen ? Palette.whenTapedButton : null,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isShowCanc = !isShowCanc;
                  isShowFullScreen = false;
                  isShowPlay = false;
                });
              },
              icon: SvgPicture.asset(
                'assets/images/Canc.svg',
                color: isShowCanc ? Palette.whenTapedButton : null,
              )),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('assets/images/Close.svg')),
        ],
      ),
      body: Center(
        child: Container(
          color: Color.fromRGBO(51, 51, 51, 1),
          child: Stack(
            children: [
              _buildContent(),
              isShowFullScreen
                  ? Positioned(
                      child: Center(
                      child: Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        decoration: isShowFullScreen
                            ? BoxDecoration(
                                image: DecorationImage(
                                image: NetworkImage(
                                    widget.imagesUrl![_currnetInex!].img),
                              ))
                            : null,
                      ),
                    ))
                  : Positioned.fill(
                      child: Container(
                      height: 0.1,
                      width: 0.1,
                    ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            top: 82,
            left: 46,
            right: 64,
            bottom: 140,
            child: Container(
                color: Color.fromRGBO(51, 51, 51, 1),
                child: _buildPhotoViewGallery())),
        isShowCanc
            ? Positioned.fill(
                top: 400,
                bottom: 25.0,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildIndicator()))
            : Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 0.1,
                  ),
                ),
              ),
      ],
    );
  }

  CarouselSlider _buildPhotoViewGallery() {
    return CarouselSlider.builder(
      itemCount: widget.imagesUrl!.length,
      itemBuilder: (ctx, index, realIndex) {
        return Container(
          padding: EdgeInsets.all(20),
          child: isShowFullScreen
              ? null
              : CachedNetworkImage(imageUrl: widget.imagesUrl![index].img),
        );
      },
      carouselController: _pageController,
      options: CarouselOptions(
          height: 400,
          autoPlay: isShowPlay,
          autoPlayInterval: Duration(seconds: 2),
          viewportFraction: 1,
          initialPage: _currnetInex!,
          onPageChanged: (int value, CarouselPageChangedReason) {
            _currnetInex = value;
          }),
    );
    // return PhotoViewGallery.builder(
    //   itemCount: widget.imagesUrl!.length,
    //   builder: (BuildContext context, int index) {
    //     return PhotoViewGalleryPageOptions(
    //       imageProvider: NetworkImage(
    //         '${widget.imagesUrl![index].img}',
    //       ),
    //       minScale: PhotoViewComputedScale.contained * 0.8,
    //     );
    //   },
    //   backgroundDecoration: BoxDecoration(color: Color.fromRGBO(51, 51, 51, 1)),
    //   enableRotation: false,
    //   scrollPhysics: const BouncingScrollPhysics(),
    //   pageController: _pageController,
    //   onPageChanged: (int index) {
    //     setState(() {
    //       _currnetInex = index;
    //     });
    //   },
    // );
  }

  Widget _buildIndicator() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: _buildImageCarouselSlider(),
    );
  }

  Widget _buildImageCarouselSlider() {
    return CarouselSlider.builder(
      itemCount: widget.imagesUrl?.length,
      itemBuilder: (ctx, index, realIdx) {
        return PortfolioGalleryImageWidget(
            imagePath: widget.imagesUrl![index].img,
            onImageTap: () => _pageController!.jumpToPage(index));
      },
      options: CarouselOptions(
          viewportFraction: 0.21,
          enlargeCenterPage: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlay: false,
          height: 100,
          initialPage: _currnetInex!),
    );
  }
}
// class GalleryPhotoViewWrapper extends StatefulWidget {
//   GalleryPhotoViewWrapper({
//     this.loadingBuilder,
//     this.backgroundDecoration,
//     this.minScale,
//     this.maxScale,
//     this.initialIndex = 0,
//     required this.galleryItems,
//     this.scrollDirection = Axis.horizontal,
//   }) : pageController = PageController(initialPage: initialIndex);

//   final BoxDecoration? backgroundDecoration;
//   final List<Gellerys> galleryItems;
//   final int initialIndex;
//   final LoadingBuilder? loadingBuilder;
//   final dynamic maxScale;
//   final dynamic minScale;
//   final PageController pageController;
//   final Axis scrollDirection;

//   @override
//   State<StatefulWidget> createState() {
//     return _GalleryPhotoViewWrapperState();
//   }
// }

// class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
//   late int currentIndex = widget.initialIndex;
//   bool isAuthoPlay = false;
//   bool isFullActive = false;
//   bool isCancActive = false;

//   void onPageChanged(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
//     final Gellerys item = widget.galleryItems[index];
//     return item.isSvg
//         ? PhotoViewGalleryPageOptions.customChild(
//             child: Container(
//               color: Color.fromRGBO(31, 31, 31, 0.9),
//               width: 228,
//               height: 300,
//               child: SvgPicture.asset(
//                 item.resource,
//                 height: 300.0,
//               ),
//             ),
//             childSize: const Size(228, 300),
//             initialScale: PhotoViewComputedScale.contained,
//             minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
//             maxScale: PhotoViewComputedScale.covered * 4.1,
//             heroAttributes: PhotoViewHeroAttributes(tag: item.id),
//           )
//         : PhotoViewGalleryPageOptions(
//             imageProvider: AssetImage(item.resource),
//             initialScale: PhotoViewComputedScale.contained,
//             minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
//             maxScale: PhotoViewComputedScale.covered * 4.1,
//             heroAttributes: PhotoViewHeroAttributes(tag: item.id),
//           );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Color.fromRGBO(31, 31, 31, 0.9),
//         constraints: BoxConstraints.expand(
//           height: MediaQuery.of(context).size.height,
//         ),
//         child: Stack(
//           alignment: Alignment.bottomRight,
//           children: <Widget>[
//             // isAuthoPlay
//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   color: Color.fromRGBO(31, 31, 31, 0.9),
//                   child: CarouselSlider.builder(
//                     itemCount: widget.galleryItems.length,
//                     itemBuilder: (context, index, reaIndex) {
//                       final source = galleryItems[index];

//                       return buildImage(source.resource, index);
//                     },
//                     options: CarouselOptions(
//                       initialPage: currentIndex,
//                       autoPlay: isAuthoPlay,
//                       autoPlayAnimationDuration: Duration(seconds: 1),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             //     : PhotoViewGallery.builder(
//             //         scrollPhysics: const BouncingScrollPhysics(),
//             //         builder: _buildItem,
//             //         itemCount: widget.galleryItems.length,
//             //         loadingBuilder: widget.loadingBuilder,
//             //         backgroundDecoration: widget.backgroundDecoration,
//             //         pageController: widget.pageController,
//             //         onPageChanged: onPageChanged,
//             //         scrollDirection: widget.scrollDirection,
//             //         customSize: Size(228, 300),
//             //       ),
//             // isFullActive
//             //     ? Container(
//             //         width: MediaQuery.of(context).size.width,
//             //         height: MediaQuery.of(context).size.height,
//             //         child: Image.asset(
//             //           galleryItems.last.resource,
//             //           fit: BoxFit.fill,
//             //         ),
//             //       )
//             //     : Container(
//             //         height: 0.1,
//             //       ),
//             Positioned.fill(
//               top: 42,
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Spacer(),
//                       Flexible(
//                         flex: 2,
//                         child: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               isAuthoPlay = !isAuthoPlay;
//                               isFullActive = false;
//                               isCancActive = false;
//                             });
//                           },
//                           icon: SvgPicture.asset(
//                             'assets/images/Play 1.svg',
//                             color: isAuthoPlay ? Palette.whenTapedButton : null,
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 2,
//                         child: IconButton(
//                           onPressed: () {
//                             isAuthoPlay = false;
//                             isFullActive = !isFullActive;
//                             isCancActive = false;
//                           },
//                           icon: SvgPicture.asset(
//                             'assets/images/Full screen 1.svg',
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 2,
//                         child: IconButton(
//                           onPressed: () {
//                             isCancActive = !isCancActive;
//                             isFullActive = false;
//                             isAuthoPlay = false;
//                           },
//                           icon: SvgPicture.asset(
//                             'assets/images/Canc.svg',
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 2,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: SvgPicture.asset(
//                             'assets/images/Close.svg',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildImage(String urlImage, index) {
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 50.0),
//         color: Color.fromRGBO(31, 31, 31, 0.9),
//         width: double.infinity,
//         child: CachedNetworkImage(
//           imageUrl: urlImage,
//         ));
//   }
// }
class PortfolioGalleryImageWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onImageTap;

  const PortfolioGalleryImageWidget(
      {Key? key, required this.imagePath, required this.onImageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(14, 14, 14, 0.7),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          child: Ink.image(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
            child: InkWell(onTap: onImageTap),
          ),
        ),
      ),
    );
  }
}
