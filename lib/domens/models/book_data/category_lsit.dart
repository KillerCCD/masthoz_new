class BookCategory {
  final String categoryTitle;
  final int id;

  BookCategory({required this.categoryTitle, required this.id});

  factory BookCategory.fromJson(Map<String, dynamic> json) {
    return BookCategory(categoryTitle: json['category_title'], id: json['id']);
  }
}
