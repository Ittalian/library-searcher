import 'package:flutter/material.dart';
import 'package:library_searcher/views/result/result_book_view.dart';
import 'package:library_searcher/views/result/result_view.dart';
import 'package:library_searcher/views/search/search_book_view.dart';

class Routes {
  static const String search = 'search';
  static const String searchBook = 'search_book';
  static const String result = 'result';
  static const String resultBook = 'book_result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case searchBook:
        return MaterialPageRoute(
          builder: (_) => const SearchBookView(),
        );
      case result:
        final resultOptions = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => ResultView(
            books: resultOptions['books'],
          ),
        );
      case resultBook:
        final resultBookOptions = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => ResultBookView(bookDetails: resultBookOptions['bookDetails']),);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name}は存在しません',
                  style: const TextStyle(fontSize: 20)),
            ),
          ),
        );
    }
  }
}
