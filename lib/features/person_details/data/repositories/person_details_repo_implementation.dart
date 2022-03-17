import 'package:dartz/dartz.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/person_details_repo.dart';
import '../datasources/person_details_remote_data_source.dart';

class PersonDetailsRepositoryImplementation extends PersonDetailsRepository {
  final NetworkInfo networkInfo;
  final PersonDetailsRemoteDataSource remoteDataSource;
  PersonDetailsRepositoryImplementation(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<String>>> getImagesList(int personID) async {
    final List<String> imagesList;
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return Left(InternetFailure());
      }
      imagesList = await remoteDataSource.getPersonImages(personID);
    } on ServerException catch (e) {
      return Left(ServerFailure(failureMessage: e.exceptionMessage));
    } catch (e) {
      return Left(InternetFailure());
    }

    return Right(imagesList);
  }
}
