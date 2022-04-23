import 'dart:convert';

import 'content_list.dart';

Search searchFromMap(String str) => Search.fromJson(json.decode(str));

// String searchToMap(Search data) => json.encode(data.toMap());

class Search {
  int? id;
  String? title;
  String? imageUrl;
  final  Map<String,Search>? type;
  Content? content;

  Search({
    this.id,
    this.title,
    this.imageUrl,
    this.type,
    this.content,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        //type: json["type"] == null ? null : Search.fromJson(json["type"]),
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
      );

  // Map<String, dynamic> toMap() => {
  //     "id": id,
  //     "title": title,
  //     "image_url": imageUrl,
  //     "book": book == null ? null : book.toMap(),
  //     "content": content == null ? null : content.toMap(),
  // };
}
