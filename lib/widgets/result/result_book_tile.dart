import 'package:flutter/material.dart';
import 'package:library_searcher/config/routes.dart';
import 'package:library_searcher/models/book.dart';
import 'package:library_searcher/models/book_detail.dart';
import 'package:library_searcher/services/book_search_service.dart';
import 'package:library_searcher/utils/constants.dart' as constant;
import 'package:library_searcher/widgets/base/base_text_button.dart';
import 'package:library_searcher/widgets/loading/loading_dialog.dart';

class ResultBookTile extends StatelessWidget {
  final BookDetail bookDetail;

  const ResultBookTile({
    super.key,
    required this.bookDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      color: Colors.white.withOpacity(0.5),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(bookDetail.imageUrl ?? constant.noImage),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            bookDetail.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          BaseTextButton(
            label: '図書館を検索',
            onPressed: () async {
              onTapSearch(context);
            },
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void onTapSearch(BuildContext context) async {
    List<Book> books = [];
    await LoadingDialog.show(context, ('検索中'));
    books = await BookSearchService(isbn: bookDetail.isbn).getBooks();
    await LoadingDialog.hide(context);
    if (books.isEmpty) {
      throw showErrorMessage(context, '該当する文書がありません');
    } else {
      moveResult(context, books);
    }
  }

  showErrorMessage(BuildContext context, String errorMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void moveResult(BuildContext context, List<Book> books) {
    Navigator.pushNamed(
      context,
      Routes.result,
      arguments: {
        'books': books,
      },
    );
  }
}
