import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/popular_people_search_result_model.dart';
import '../repositories/popular_people_repo.dart';

class FetchPopularPeopleUsecase
    extends Usecase<PopularPeopleSearchResultModel, FetchPopularPeopleParams> {
  final PopularPeopleRepository repository;
  FetchPopularPeopleUsecase(this.repository);

  @override
  Future<Either<Failure, PopularPeopleSearchResultModel>> call(
      FetchPopularPeopleParams params) async {
    return await repository.fetchPopularPersonsList(params.pageNo);
  }
}

class FetchPopularPeopleParams {
  final int pageNo;

  FetchPopularPeopleParams({required this.pageNo});
}
