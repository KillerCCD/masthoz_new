import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/domens/models/book_data/content_list.dart';

class BookInheritedWidget extends InheritedWidget {
  BookInheritedWidget(this.content, {Key? key, required this.child})
      : super(key: key, child: child);

  final Widget child;
  final Content? content;

  @override
  bool updateShouldNotify(BookInheritedWidget oldWidget) {
    return true;
  }

  static BookInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BookInheritedWidget>();
  }
}
