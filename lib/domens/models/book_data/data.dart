class Data {
  Data(
      {this.id,
      this.image,
      this.title,
      this.body,
      this.type,
      this.explanation,
      this.firstCharacter,
      this.link,
      this.summary,
      this.video_link});

  final int? id;
  final String? image;
  final String? title;
  final String? body;
  final String? type;
  final dynamic link;
  final String? video_link;
  final String? firstCharacter;
  final String? explanation;
  final String? summary;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        body: json["body"] == null ? null : json["body"],
        summary: json["summary"] == null ? null : json["summary"],
        link: json["link"] == null ? null : json["link"],
        firstCharacter:
            json["first_character"] == null ? null : json["first_character"],
        explanation: json["explanation"] == null ? null : json["explanation"],
         video_link: json["video_link"] == null ? null : json["video_link"],
      );
}
