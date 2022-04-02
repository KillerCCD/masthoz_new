class Book {
  final String title;
  final String bookName;
  final String imageUrl;
  Book({
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
