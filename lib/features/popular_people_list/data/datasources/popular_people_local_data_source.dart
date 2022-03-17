import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import '../../../../core/errors/exception.dart';
import '../../../../utils/constants.dart';
import '../models/popular_person_model.dart';

abstract class PopularPeopleLocalDataSource {
  List<PopularPersonModel> getPopularPersonsList();
  Future<void> storePopularPersonsList(String personsListJson);
  Future<void> clearStoredPersonsList();
}

class PopularPeopleLocalDataSourceImplementation
    extends PopularPeopleLocalDataSource {
  @override
  Future<void> clearStoredPersonsList() async =>
      await Hive.box(personBoxName).clear();

  @override
  List<PopularPersonModel> getPopularPersonsList() {
    final boxValues = Hive.box(personBoxName).values.toList();

    if (boxValues.isEmpty) {
      throw NoCachedDataFoundException();
    }

    return PopularPersonModel.decodePersonsList(jsonDecode(boxValues.first));
  }

  @override
  Future<void> storePopularPersonsList(String personsListJson) async =>
      await Hive.box(personBoxName).add(personsListJson);
}
