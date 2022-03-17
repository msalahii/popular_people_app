import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/popular_people_search_result_model.dart';

abstract class PopularPeopleRepository{
  Future<Either<Failure, PopularPeopleSearchResultModel>> fetchPopularPersonsList(int pageNo);
}