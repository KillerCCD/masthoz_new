import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/fake_book_data.dart';
import 'package:mashtoz_flutter/domens/models/book_data/book.dart';
import 'package:mashtoz_flutter/domens/models/book_data/gallery_data.dart';
import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';
import 'package:mashtoz_flutter/ui/widgets/helper_widgets/menuShow.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryItem extends StatefulWidget {
  const GalleryItem({Key? key}) : super(key: key);

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
        ),
      ),
    );
  }

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
        body: CustomScrollView(slivers: [
      //  SliverAppBar(
      //   expandedHeight: 73,
      //   backgroundColor: Palette.textLineOrBackGroundColor,
      //   pinned: false,
      //   floating: true,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   systemOverlayStyle:
      //       SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
      //   flexibleSpace: ActionsHelper(
      //     leftPadding: 12,
      //     text: 'Պատկերադարան',
      //     fontFamily: 'GHEAGrapalat',
      //     fontSize: 20,
      //     laterSpacing: 1,
      //     fontWeight: FontWeight.bold,
      //     color: Palette.appBarTitleColor,
      //   ),
      // ),
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
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: MenuShow(),
          ),
        ],
      ),
      SliverFillRemaining(
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
                data?.asMap().values.map((e) => e);
                print('data Run time : ${data.runtimeType}');
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      dynamic newData = data?[index];

                      return ExpansionTile(
                        title: SizedBox(
                          child: Text(
                            '${newData}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        //initalIcon: SvgPicture.asset('assets/images/line24.svg'),
                        //leading: Icon(Icons.rotate_90_degrees_ccw),
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data?.length,
                            itemBuilder: (context, index) {
                              dynamic gallery = data![index];

                              //  print(gallery.image);
                              return Text('${gallery}');
                              // return Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 5.0),Y
                              //     child: GestureDetector(
                              //       onTap: () {
                              //         open(context, index);
                              //       },
                              //       child: Hero(
                              //         tag: gallery.id.toString(),
                              //         child: CachedNetworkImage(
                              //           imageUrl: gallery.image!,
                              //         ),
                              //       ),
                              //     ));
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20.0,
                            ),
                          )
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
      )

      // SliverFillRemaining(
      //   child: GridView.builder(
      //     shrinkWrap: true,
      //     scrollDirection: Axis.vertical,
      //     itemCount: galleryItems.length,
      //     itemBuilder: (context, index) {
      //       Gellerys gallery = galleryItems[index];
      //       print(gallery.resource);
      //       // return Text('data');
      //     return  GalleryExampleItemThumbnail(
      //         galleryExampleItem: galleryItems[0],
      //         onTap: () {
      //           open(context, index);
      //         },
      //       );
      //     },
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         //       crossAxisCount: 2,
      //         //       mainAxisSpacing: 20.0,
      //         //     ),
      //         //   ),
      //         // )
      //       ],
      //     ),
      //   );
      // }
    ]));
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final BoxDecoration? backgroundDecoration;
  final List<Gellerys> galleryItems;
  final int initialIndex;
  final LoadingBuilder? loadingBuilder;
  final dynamic maxScale;
  final dynamic minScale;
  final PageController pageController;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final Gellerys item = widget.galleryItems[index];
    return item.isSvg
        ? PhotoViewGalleryPageOptions.customChild(
            child: Container(
              width: 300,
              height: 300,
              child: SvgPicture.asset(
                item.resource,
                height: 200.0,
              ),
            ),
            childSize: const Size(300, 300),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 4.1,
            heroAttributes: PhotoViewHeroAttributes(tag: item.id),
          )
        : PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(item.resource),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 4.1,
            heroAttributes: PhotoViewHeroAttributes(tag: item.id),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
