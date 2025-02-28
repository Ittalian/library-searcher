import 'package:flutter/material.dart';
import 'package:library_searcher/models/book_detail.dart';
import 'package:library_searcher/utils/constants.dart' as constant;

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
        ],
      ),
    );
  }
}
