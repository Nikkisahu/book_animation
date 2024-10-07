class BookPage {
  BookPage({
    required this.pageImgUrl,
    required this.pageText,
  });

  final String pageImgUrl;
  final String pageText;
}

class Book {
  Book({
    required this.bookAuthorImgUrl,
    required this.bookCoverImgUrl,
    required this.pages,
  });

  final String bookAuthorImgUrl;
  final String bookCoverImgUrl;
  final List<BookPage> pages;
}
