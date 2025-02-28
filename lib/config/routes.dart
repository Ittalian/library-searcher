import 'package:flutter/material.dart';
import 'package:library_searcher/views/result/result_view.dart';

class Routes {
  static const String search = 'search';
  static const String result = 'result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case result:
        final resultOptions = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => ResultView(
            books: resultOptions['books'],
          ),
        );
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
