import '../../domain/entities/popular_person.dart';

class PopularPersonModel extends PopularPerson {
  const PopularPersonModel({
    required int personID,
    required String name,
    required String? imageURL,
    required String department,
  }) : super(
            personID: personID,
            name: name,
            imageURL: imageURL,
            department: department);

  factory PopularPersonModel.fromJson(Map<String, dynamic> json) {
    return PopularPersonModel(
        personID: json['id'],
        name: json['name'] ?? 'N/A',
        imageURL: json['profile_path'],
        department: json['known_for_department'] ?? 'Not Specified');
  }

  toJson() => {
        'id': personID,
        'name': name,
        'profile_path': imageURL,
        'known_for_department': department
      };

  static List<PopularPersonModel> decodePersonsList(
          List<dynamic> personsList) =>
      personsList
          .map<PopularPersonModel>(
              (person) => PopularPersonModel.fromJson(person))
          .toList();
}
