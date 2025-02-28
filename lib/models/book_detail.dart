class BookDetail {
  final String title;
  final String isbn;
  final String? imageUrl;

  BookDetail({
    required this.title,
    required this.isbn,
    this.imageUrl,
  });
}
