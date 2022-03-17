import 'package:equatable/equatable.dart';

class PopularPerson extends Equatable {
  final int personID;
  final String name;
  final String imageURL;
  final String department;

  const PopularPerson(
      {required this.personID,
      required this.name,
      required this.imageURL,
      required this.department});

  @override
  List<Object?> get props => [personID, name, imageURL];
}
