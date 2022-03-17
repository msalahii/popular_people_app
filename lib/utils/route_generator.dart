import 'package:flutter/material.dart';

import '../features/person_details/presentation/pages/person_details_view.dart';
import '../features/person_details/presentation/pages/person_details_view_arguments.dart';
import '../features/popular_people_list/presentation/pages/popular_people_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PopularPeopleView.routeName:
        return MaterialPageRoute(builder: (_) => const PopularPeopleView());

      case PersonDetailsView.routeName:
        return MaterialPageRoute(
            builder: (_) => PersonDetailsView(
                arguments: settings.arguments as PersonDetailsViewArguments));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Invalid Route')),
                ));
    }
  }
}
