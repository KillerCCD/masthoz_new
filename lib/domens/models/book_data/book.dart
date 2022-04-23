import 'package:flutter/material.dart';

class Book {
  final String title;
  final String bookName;
  final String imageUrl;
  final String body;
  const Book({
    required this.body,
    required this.bookName,
    required this.title,
    required this.imageUrl,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'imageUrl': imageUrl,
  //   };
  // }

  // factory Book.fromJson(Map<String, dynamic> json) {
  //   return Book(
  //     bookName: json['bookName'],
  //     title: json['title'],
  //     imageUrl: json['imageUrl'],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  //factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}

class IalianLesson {
  final int id;
  final String title;
  final String image;
  final String number;
  final String link;
  IalianLesson({
    required this.id,
    required this.title,
    required this.image,
    required this.number,
    required this.link,
  });
}

class Gellerys {
  Gellerys({
    required this.id,
    required this.resource,
    this.isSvg = false,
  });

  final String id;
  final String resource;
  final bool isSvg;
}
class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail({
    Key? key,
    required this.galleryExampleItem,
    required this.onTap,
  }) : super(key: key);

  final Gellerys galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryExampleItem.id,
          child: Image.asset(galleryExampleItem.resource, height: 80.0),
        ),
      ),
    );
  }
}