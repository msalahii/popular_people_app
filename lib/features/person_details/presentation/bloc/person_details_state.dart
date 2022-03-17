part of 'person_details_bloc.dart';

abstract class PersonDetailsState extends Equatable {
  const PersonDetailsState();

  @override
  List<Object> get props => [];
}

class PersonDetailsInitial extends PersonDetailsState {}

class FetchPersonImagesLoadingState extends PersonDetailsState {}

class FetchPersonImagesFailedState extends PersonDetailsState {
  final String message;

  const FetchPersonImagesFailedState({required this.message});
}

class FetchPersonImagesSuccessState extends PersonDetailsState {
  final List<String> imagesList;

  const FetchPersonImagesSuccessState({required this.imagesList});
}
