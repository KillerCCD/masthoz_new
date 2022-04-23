
class Data {
  Data({
    this.id,
    this.image,
    this.title,
    this.body,
    this.type,
  });

  final int? id;
  final String? image;
  final String? title;
  final String? body;
  final String? type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        body: json["body"] == null ? null : json["body"],
      );
}
