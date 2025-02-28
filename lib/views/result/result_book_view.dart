import 'package:flutter/material.dart';
import 'package:library_searcher/models/book_detail.dart';
import 'package:library_searcher/widgets/base/base_image_container.dart';
import 'package:library_searcher/widgets/result/result_book_tile.dart';

class ResultBookView extends StatelessWidget {
  final List<BookDetail> bookDetails;

  const ResultBookView({
    super.key,
    required this.bookDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: BaseImageContainer(
        imagePath: 'images/book.jpg',
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var bookDetail in bookDetails)
                ResultBookTile(bookDetail: bookDetail)
            ],
          ),
        ),
      ),
    );
  }
}
