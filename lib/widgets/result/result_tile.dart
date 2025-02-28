import 'package:flutter/material.dart';
import 'package:library_searcher/models/book.dart';

class ResultTile extends StatelessWidget {
  final Book book;

  const ResultTile({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _generateColor(book.status),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(book.library),
          const Padding(padding: EdgeInsets.only(top: 5)),
          Text(book.status),
        ],
      ),
    );
  }

  Color _generateColor(String status) {
    switch (status) {
      case '貸出可':
        return Colors.blue;
      case '貸出中':
        return Colors.orange;
      default:
        return Colors.pink[100]!;
    }
  }
}
