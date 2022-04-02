



class Content {
  Content({
    required this.id,
    required this.title,
    required this.image,
    required this.body,
    required this.videoLink,
    required this.explanation,
    required this.author,
    required this.content,
  });

  final int? id;
  final String? title;
  final String? image;
  final String? body;
  final String? videoLink;
  final String? explanation;
  final String? author;
  final Map<String, Content>? content;

  factory Content.fromJson(Map<String, dynamic> json) {
    // content = Content(
    //   id: json["id"],
    //   title: json["title"],
    //   image: json["image"],
    //   body: json["body"],
    //   videoLink: json["video_link"],
    //   explanation: json["explanation"],
    //   author: json["author"],
    //   content: json['content'],
    // );

    // return Content(
    //     id: "55",
    //     title: "New Book",
    //     image:
    //         "https://mashtoz.org/storage/files/rom-vatikan-basilika-st-peter-die-taube-des-heiligen-geistes-cathedra-petri-bernini.jpg",
    //     body: "body of the book",
    //     videoLink:
    //         "https://mashtoz.org/storage/files/rom-vatikan-basilika-st-peter-die-taube-des-heiligen-geistes-cathedra-petri-bernini.jpg",
    //     explanation: "explanation",
    //     author: "I am author",
    //     content: "hehe");

    return Content(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      body: json["body"],
      videoLink: json["video_link"],
      explanation: json["explanation"],
      author: json["author"],
      content: json["content"] == null
          ? null
          : Map.from(json["content"])
              .map((k, v) => MapEntry<String, Content>(k, Content.fromJson(v))),
    );
  }

  // factory Content.coverJson(Map<String, dynamic> json) {
  //   return Content(
  //     id: json["id"],
  //     title: json["title"],
  //     image: json["image"],
  //     body: json["body"],
  //     videoLink: json["video_link"],
  //     explanation: json["explanation"],
  //     author: json["author"],
  //     content: json['content'],
  //   );
  // }
  // factory Content.viewJson(Map<String, dynamic> json) {
  //   return Content(
  //     id: json["id"],
  //     title: json["title"],
  //     image: json["image"],
  //     body: json["body"],
  //     videoLink: json["video_link"],
  //     explanation: json["explanation"],
  //     author: json["author"],
  //     content: json['content'],
  //   );
  // }
}
