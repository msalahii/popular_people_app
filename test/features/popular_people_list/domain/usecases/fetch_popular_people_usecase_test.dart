import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular_people_app/features/popular_people_list/data/models/popular_people_search_result_model.dart';
import 'package:popular_people_app/features/popular_people_list/data/models/popular_person_model.dart';
import 'package:popular_people_app/features/popular_people_list/domain/repositories/popular_people_repo.dart';
import 'package:popular_people_app/features/popular_people_list/domain/usecases/fetch_popular_people_usecase.dart';

import 'fetch_popular_people_usecase_test.mocks.dart';

@GenerateMocks([PopularPeopleRepository])
void main() {
  late FetchPopularPeopleUsecase usecase;
  late MockPopularPeopleRepository repository;

  setUp(() {
    repository = MockPopularPeopleRepository();
    usecase = FetchPopularPeopleUsecase(repository);
  });

  const searchResults = PopularPeopleSearchResultModel(pageNo: 1, personsList: [
    PopularPersonModel(
        personID: 1,
        name: 'name',
        imageURL: 'imageURL',
        department: 'department')
  ]);

  test(
    'should fetch popular people list from the repository',
    () async {
      // arrange
      when(repository.fetchPopularPersonsList(1))
          .thenAnswer((_) async => Right(searchResults));
      // act
      final params = FetchPopularPeopleParams(pageNo: 1);
      final result = await usecase(params);

      // assert
      expect(result, const Right(searchResults));
      verify(repository.fetchPopularPersonsList(1));
      verifyNoMoreInteractions(repository);
    },
  );
}
