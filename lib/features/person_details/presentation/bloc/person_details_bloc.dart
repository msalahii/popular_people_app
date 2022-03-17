import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/fetch_person_images_usecase.dart';
part 'person_details_event.dart';
part 'person_details_state.dart';

class PersonDetailsBloc extends Bloc<PersonDetailsEvent, PersonDetailsState> {
  final FetchPersonImagesUsecase fetchPersonImagesUsecase;
  PersonDetailsBloc({required this.fetchPersonImagesUsecase})
      : super(PersonDetailsInitial()) {
    on<FetchPersonImagesListEvent>((event, emit) async {
      emit(FetchPersonImagesLoadingState());
      final params = FetchPersonImagesParams(personID: event.personID);
      final result = await fetchPersonImagesUsecase(params);
      result.fold(
          (failure) =>
              emit(FetchPersonImagesFailedState(message: failure.message)),
          (success) =>
              emit(FetchPersonImagesSuccessState(imagesList: success)));
    });
  }
}
