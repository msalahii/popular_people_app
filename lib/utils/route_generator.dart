import 'package:flutter/material.dart';

import '../features/popular_people_list/presentation/pages/popular_people_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PopularPeopleView.routeName:
        return MaterialPageRoute(builder: (_) => const PopularPeopleView());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Invalid Route')),
                ));
    }
  }
}
