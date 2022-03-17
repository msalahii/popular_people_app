part of 'popular_people_list_bloc.dart';

abstract class PopularPeopleListEvent extends Equatable {
  const PopularPeopleListEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularPersonsListEvent extends PopularPeopleListEvent {
  final bool isLoadMore;

  const FetchPopularPersonsListEvent({required this.isLoadMore});
}
