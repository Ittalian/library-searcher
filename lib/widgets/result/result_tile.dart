import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {
  final String library;
  final String status;

  const ResultTile({
    super.key,
    required this.library,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(library),
        Text(status),
      ],
    );
  }
}
