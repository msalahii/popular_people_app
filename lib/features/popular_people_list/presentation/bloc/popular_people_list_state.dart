part of 'popular_people_list_bloc.dart';

abstract class PopularPeopleListState extends Equatable {
  const PopularPeopleListState();

  @override
  List<Object> get props => [];
}

class PopularPeopleListInitial extends PopularPeopleListState {}

class FetchPopularPersonsLoadingState extends PopularPeopleListState {}

class FetchPopularPersonsFailedState extends PopularPeopleListState {
  final String failureMessage;

  const FetchPopularPersonsFailedState({required this.failureMessage});
}

class FetchPopularPersonsSuccessState extends PopularPeopleListState {
  final List<PopularPersonModel> personsList;

  const FetchPopularPersonsSuccessState({required this.personsList});
}
