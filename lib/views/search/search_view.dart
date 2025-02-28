import 'package:flutter/material.dart';
import 'package:library_searcher/config/routes.dart';
import 'package:library_searcher/models/book.dart';
import 'package:library_searcher/services/book_search_service.dart';
import 'package:library_searcher/widgets/base/base_button.dart';
import 'package:library_searcher/widgets/base/base_image_container.dart';
import 'package:library_searcher/widgets/base/base_textform_field.dart';
import 'package:library_searcher/widgets/loading/loading_dialog.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
  });

  @override
  State<SearchView> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  String isbn = '';

  void setIsbn(String value) {
    setState(() {
      isbn = value;
    });
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

  showErrorMessage(String errorMessage) {
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

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: 'images/search.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseTextformField(
              label: 'ISBN',
              setValue: (value) => setIsbn(value),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            BaseButton(
              label: '検索',
              onPressed: () async {
                List<Book> books = [];
                await LoadingDialog.show(context, ('検索中'));
                books = await BookSearchService(isbn: isbn).getBooks();
                await LoadingDialog.hide(context);
                if (books.isEmpty) {
                  throw showErrorMessage('該当する文書がありません');
                } else {
                  moveResult(context, books);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
