import 'package:flutter/material.dart';
import 'package:library_searcher/config/routes.dart';
import 'package:library_searcher/models/book_detail.dart';
import 'package:library_searcher/services/book_detail_search_service.dart';
import 'package:library_searcher/widgets/base/base_button.dart';
import 'package:library_searcher/widgets/base/base_image_container.dart';
import 'package:library_searcher/widgets/base/base_textform_field.dart';
import 'package:library_searcher/widgets/loading/loading_dialog.dart';

class SearchBookView extends StatefulWidget {
  const SearchBookView({
    super.key,
  });

  @override
  State<SearchBookView> createState() => SearchBookViewState();
}

class SearchBookViewState extends State<SearchBookView> {
  String title = '';

  void setTitle(String value) {
    setState(() {
      title = value;
    });
  }

  void moveResult(BuildContext context, List<BookDetail> bookDetails) {
    Navigator.pushNamed(
      context,
      Routes.resultBook,
      arguments: {
        'bookDetails': bookDetails,
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
      imagePath: 'images/book_search.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseTextformField(
              label: 'タイトル',
              setValue: (value) => setTitle(value),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            BaseButton(
              label: '検索',
              onPressed: () async {
                List<BookDetail> bookDetails = [];
                // await LoadingDialog.show(context, ('検索中'));
                bookDetails = await BookDetailSearchService(title: title)
                    .getBookDetails();
                // await LoadingDialog.hide(context);
                if (bookDetails.isEmpty) {
                  throw showErrorMessage('該当する文書がありません');
                } else {
                  moveResult(context, bookDetails);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
