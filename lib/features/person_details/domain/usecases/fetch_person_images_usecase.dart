import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/person_details_repo.dart';

class FetchPersonImagesUsecase
    extends Usecase<List<String>, FetchPersonImagesParams> {
  final PersonDetailsRepository repository;

  FetchPersonImagesUsecase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(params) async {
    return await repository.getImagesList(params.personID);
  }
}

class FetchPersonImagesParams {
  final int personID;

  FetchPersonImagesParams({required this.personID});
}
