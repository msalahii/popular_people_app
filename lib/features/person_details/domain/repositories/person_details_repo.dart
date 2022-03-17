import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class PersonDetailsRepository {
  Future<Either<Failure, List<String>>> getImagesList(int personID);
}
