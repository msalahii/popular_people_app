import 'package:flutter_test/flutter_test.dart';
import 'package:popular_people_app/features/popular_people_list/data/models/popular_person_model.dart';
import 'package:popular_people_app/features/popular_people_list/domain/entities/popular_person.dart';

void main() {
  const personModel = PopularPersonModel(
      personID: 1,
      name: "person",
      imageURL: "image.com",
      department: "department");

  test('PopularPersonModel should be a sub-class from PopularPerson Entity', () {
    expect(personModel, isA<PopularPerson>());
  });
}
