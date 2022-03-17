import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/popular_people_repo.dart';
import '../datasources/popular_people_local_data_source.dart';
import '../datasources/popular_people_remote_data_source.dart';
import '../models/popular_people_search_result_model.dart';

class PopularPeopleRepositoryImplementation extends PopularPeopleRepository {
  final NetworkInfo networkInfo;
  final PopularPeopleRemoteDataSource remoteDataSource;
  final PopularPeopleLocalDataSource localDataSource;
  PopularPeopleRepositoryImplementation(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, PopularPeopleSearchResultModel>>
      fetchPopularPersonsList(int pageNo) async {
    PopularPeopleSearchResultModel searchResult;
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        final personsList = localDataSource.getPopularPersonsList();
        searchResult =
            PopularPeopleSearchResultModel(pageNo: 1, personsList: personsList);
      } else {
        searchResult = await remoteDataSource.getPopularPersonsList(pageNo);
        await localDataSource.clearStoredPersonsList();
        final personsListJson = jsonEncode(
            searchResult.personsList.map((e) => e.toJson()).toList());
        await localDataSource.storePopularPersonsList(personsListJson);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(failureMessage: e.exceptionMessage));
    } on NoCachedDataFoundException {
      return const Left(ServerFailure(failureMessage: "No Cached Data Found"));
    } catch (e) {
      return Left(InternetFailure());
    }

    return Right(searchResult);
  }
}
