import 'package:flutter/material.dart';
import 'package:library_searcher/models/book.dart';
import 'package:library_searcher/widgets/base/base_image_container.dart';
import 'package:library_searcher/widgets/result/result_tile.dart';

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
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: books.map((book) {
                  return SizedBox(
                    child: ResultTile(book: book),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
    );
  }
}
