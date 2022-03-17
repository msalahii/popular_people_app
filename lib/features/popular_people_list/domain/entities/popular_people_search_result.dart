import 'package:equatable/equatable.dart';
import '../../data/models/popular_person_model.dart';

class PopularPeopleSearchResult extends Equatable {
  final int pageNo;
  final List<PopularPersonModel> personsList;

  const PopularPeopleSearchResult(
      {required this.pageNo, required this.personsList});

  @override
  List<Object?> get props => [pageNo, personsList];
}
