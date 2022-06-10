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
    return Content(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      image: json["image"] == null ? null : json["image"],
      body: json["body"] == null ? null : json["body"],
      videoLink: json["video_link"] == null ? null : json["video_link"],
      explanation: json["explanation"] == null ? null : json["explanation"],
      author: json["author"] == null ? null : json["author"],
      content: json['content'] == null
          ? null
          : Map.from(json['content'])
              .map((key, value) => MapEntry(key, Content.fromJson(value))),
    );
  }
}

class UserAccount {
  final String? type;
  final String? type_id;
  final Content content;
  const UserAccount(
      {required this.content, required this.type, required this.type_id});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      type: json['type'],
      type_id: json['type_id'],
      content: Content.fromJson(json['content']),
    );
  }
}
