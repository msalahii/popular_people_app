import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular_people_app/core/errors/exception.dart';
import 'package:popular_people_app/core/errors/failure.dart';
import 'package:popular_people_app/core/network/network_info.dart';
import 'package:popular_people_app/features/popular_people_list/data/datasources/popular_people_local_data_source.dart';
import 'package:popular_people_app/features/popular_people_list/data/datasources/popular_people_remote_data_source.dart';
import 'package:popular_people_app/features/popular_people_list/data/models/popular_people_search_result_model.dart';
import 'package:popular_people_app/features/popular_people_list/data/repositories/popular_people_repo_implementation.dart';
import 'popular_person_repo_test.mocks.dart';

@GenerateMocks(
    [PopularPeopleRemoteDataSource, PopularPeopleLocalDataSource, NetworkInfo])
void main() {
  late PopularPeopleRepositoryImplementation repository;
  late MockPopularPeopleRemoteDataSource mockRemoteDataSource;
  late MockPopularPeopleLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockPopularPeopleRemoteDataSource();
    mockLocalDataSource = MockPopularPeopleLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PopularPeopleRepositoryImplementation(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('fetch popular people list', () {
    const pageNo = 1;
    const searchResultModel =
        PopularPeopleSearchResultModel(pageNo: 1, personsList: []);

    test('should call the remote data source when has internet connection',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await repository.fetchPopularPersonsList(pageNo);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getPopularPersonsList(pageNo)).called(1);
      verifyZeroInteractions(mockLocalDataSource);
    });

    test('should call the local data source when internet is not connected',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      await repository.fetchPopularPersonsList(pageNo);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockLocalDataSource.getPopularPersonsList()).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test(
        'should get search result data from remote data source when request success 200',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularPersonsList(pageNo))
          .thenAnswer((realInvocation) async => searchResultModel);

      // act
      final result = await repository.fetchPopularPersonsList(pageNo);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getPopularPersonsList(pageNo)).called(1);
      expect(result, Right(searchResultModel));
    });

    test('should throw server exception when request failed', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularPersonsList(pageNo)).thenThrow(
          const ServerException(exceptionMessage: 'exceptionMessage'));

      // act
      final result = await repository.fetchPopularPersonsList(pageNo);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getPopularPersonsList(pageNo));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(const Left(ServerFailure(failureMessage: ''))));
    });

    test('should throw internet exception when unexpected error occur',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularPersonsList(pageNo))
          .thenThrow(InternetException());

      // act
      final result = await repository.fetchPopularPersonsList(pageNo);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getPopularPersonsList(pageNo));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(InternetFailure())));
    });
  });
}
