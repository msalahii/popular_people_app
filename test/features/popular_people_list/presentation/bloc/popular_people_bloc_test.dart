import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular_people_app/core/errors/failure.dart';

@GenerateMocks([FetchPopularPeopleUsecase])
void main() {
  late PopularPeopleListBloc popularPeopleListBloc;
  late MockFetchPopularPeopleUsecase mockFetchPopularPeopleUsecase;

  setUp(() {
    mockFetchPopularPeopleUsecase = MockFetchPopularPeopleUsecase();
    popularPeopleListBloc = PopularPeopleListBloc(
        fetchPopularPeopleUsecase: mockFetchPopularPeopleUsecase);
  });

  final result =
      PopularPeopleSearchResultModel(pageNo: 1, personsList: const []);

  blocTest<PopularPeopleListBloc, PopularPeopleListState>(
      'should call FetchPopularUsecase once to get the data',
      build: () {
        when(mockFetchPopularPeopleUsecase(any))
            .thenAnswer((realInvocation) async => Right(result));
        return popularPeopleListBloc;
      },
      setUp: () {},
      act: (bloc) =>
          bloc.add(const FetchPopularPersonsListEvent(isLoadMore: false)),
      verify: (_) {
        verify(mockFetchPopularPeopleUsecase(any)).called(1);
      });

  blocTest<PopularPeopleListBloc, PopularPeopleListState>(
      'should emit [Sucess State] when get request success',
      build: () {
        when(mockFetchPopularPeopleUsecase(any))
            .thenAnswer((realInvocation) async => Right(result));
        return popularPeopleListBloc;
      },
      setUp: () {},
      act: (bloc) =>
          bloc.add(const FetchPopularPersonsListEvent(isLoadMore: false)),
      expect: () => [
            FetchPopularPersonsLoadingState(),
            FetchPopularPersonsSuccessState(personsList: result.personsList)
          ]);

  blocTest<PopularPeopleListBloc, PopularPeopleListState>(
      'should emit [Failed State] when get request failed',
      build: () {
        when(mockFetchPopularPeopleUsecase(any)).thenAnswer(
            (realInvocation) async => const Left(ServerFailure(failureMessage: '')));
        return popularPeopleListBloc;
      },
      setUp: () {},
      act: (bloc) =>
          bloc.add(const FetchPopularPersonsListEvent(isLoadMore: false)),
      expect: () => [
            FetchPopularPersonsLoadingState(),
            const FetchPopularPersonsFailedState(
                failureMessage: 'failureMessage')
          ]);

  blocTest<PopularPeopleListBloc, PopularPeopleListState>(
      'should emit [Failed State] when no internet connection',
      build: () {
        when(mockFetchPopularPeopleUsecase(any))
            .thenAnswer((realInvocation) async => Left(InternetFailure()));
        return popularPeopleListBloc;
      },
      setUp: () {},
      act: (bloc) =>
          bloc.add(const FetchPopularPersonsListEvent(isLoadMore: false)),
      expect: () => [
            FetchPopularPersonsLoadingState(),
            const FetchPopularPersonsFailedState(
                failureMessage: 'failureMessage')
          ]);
}
