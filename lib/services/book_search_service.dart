import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_searcher/models/book.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookSearchService {
  final String isbn;

  const BookSearchService({
    required this.isbn,
  });

  Future<List<Book>> getBooks() async {
    final url = _getUrl();
    final target = Uri.parse(url);

    while (true) {
      final response = await http.get(target);
      if (response.statusCode == 200) {
        final String jsonString = extractJsonFromCallback(response.body);
        final Map<String, dynamic> data = json.decode(jsonString);

        if (data.containsKey('continue') && data['continue'] == 1) {
          await Future.delayed(const Duration(seconds: 2));
          continue;
        }

        List<Book> books = [];
        if (data['books'] != null) {
          final statuses = data['books'][isbn]['Tokyo_Suginami']['libkey'];
          if (statuses != null) {
            statuses.forEach(
              (library, status) {
                books.add(Book(library: library, status: status));
              },
            );
          } else {
            return [];
          }
        }
        return books;
      } else {
        return [];
      }
    }
  }

  String _getUrl() {
    return 'https://api.calil.jp/check?appkey=${dotenv.get('calil_application_key')}&isbn=$isbn&systemid=Tokyo_Suginami&format=json';
  }

  String extractJsonFromCallback(String responseBody) {
    final regex = RegExp(r'callback\((.*)\)');
    final match = regex.firstMatch(responseBody);
    return match != null ? match.group(1)! : responseBody;
  }
}
