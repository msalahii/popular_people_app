import 'package:flutter_test/flutter_test.dart';

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
