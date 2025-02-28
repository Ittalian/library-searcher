import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:library_searcher/models/book_detail.dart';

import 'package:http/http.dart' as http;

class BookDetailSearchService {
  final String title;

  const BookDetailSearchService({
    required this.title,
  });

  Future<List<BookDetail>> getBookDetails() async {
    final url = _getUrl();
    final target = Uri.parse(url);
    final response = await http.get(target);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic>? items = data['Items'];
      List<BookDetail> bookDetails = [];
      if (items != null) {
        for (var item in items) {
          bookDetails.add(
            BookDetail(
              title: item['Item']['title'],
              isbn: item['Item']['isbn'],
              imageUrl: item['Item']['smallImageUrl'] ?? '',
            ),
          );
        }
        return bookDetails;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  String _getUrl() {
    return 'https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?applicationId=${dotenv.get('rakuten_application_id')}&title=$title&sort=sales';
  }
}
