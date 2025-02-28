import 'package:flutter/material.dart';
import 'package:library_searcher/config/routes.dart';
import 'package:library_searcher/views/search/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchView(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
