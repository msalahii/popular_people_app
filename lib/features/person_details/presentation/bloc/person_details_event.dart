part of 'person_details_bloc.dart';

abstract class PersonDetailsEvent extends Equatable {
  const PersonDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchPersonImagesListEvent extends PersonDetailsEvent {
  final int personID;

  const FetchPersonImagesListEvent({required this.personID});

  @override
  List<Object> get props => [personID];
}
