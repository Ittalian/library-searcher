import 'dart:convert';
import 'package:library_searcher/models/book.dart';

import 'package:http/http.dart' as http;

class BookSearchService {
  final String isbn;

  const BookSearchService({
    required this.isbn,
  });

  Future<List<Book>> getBooks() async {
    final url = _getUrl();
    final target = Uri.parse(url);
    final response = await http.get(target);
    if (response.statusCode == 200) {
      final String jsonString = extractJsonFromCallback(response.body);
      final Map<String, dynamic> data = json.decode(jsonString);
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

  String _getUrl() {
    return 'https://api.calil.jp/check?appkey=b0a3bc7971cca1c0342c3450dabdfa39&isbn=$isbn&systemid=Tokyo_Suginami&format=json';
  }

  String extractJsonFromCallback(String responseBody) {
    final regex = RegExp(r'callback\((.*)\)');
    final match = regex.firstMatch(responseBody);
    return match != null ? match.group(1)! : responseBody;
  }
}
