import 'package:popular_people_app/features/popular_people_list/data/models/popular_person_model.dart';
import '../../domain/entities/popular_people_search_result.dart';

class PopularPeopleSearchResultModel extends PopularPeopleSearchResult {
  const PopularPeopleSearchResultModel(
      {required int pageNo, required List<PopularPersonModel> personsList})
      : super(pageNo: pageNo, personsList: personsList);

  factory PopularPeopleSearchResultModel.fromJson(Map<String, dynamic> json) {
    return PopularPeopleSearchResultModel(
        pageNo: json['page'],
        personsList: PopularPersonModel.decodePersonsList(json['results']));
  }
}
