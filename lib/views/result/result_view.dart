import 'package:flutter/material.dart';
import 'package:library_searcher/models/book.dart';
import 'package:library_searcher/widgets/base/base_image_container.dart';

class ResultView extends StatelessWidget {
  final List<Book> books;

  const ResultView({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: BaseImageContainer(
        imagePath: 'images/result.jpg',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var book in books)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(book.library),
                  Text(book.status),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
