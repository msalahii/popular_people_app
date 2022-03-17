import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/popular_person_model.dart';
import '../../domain/usecases/fetch_popular_people_usecase.dart';
part 'popular_people_list_event.dart';
part 'popular_people_list_state.dart';

class PopularPeopleListBloc
    extends Bloc<PopularPeopleListEvent, PopularPeopleListState> {
  int currentPageNo = 1;
  final FetchPopularPeopleUsecase fetchPopularPeopleUsecase;
  PopularPeopleListBloc({required this.fetchPopularPeopleUsecase})
      : super(PopularPeopleListInitial()) {
    on<FetchPopularPersonsListEvent>((event, emit) async {
      emit(FetchPopularPersonsLoadingState());
      if (event.isLoadMore) {
        currentPageNo++;
      }
      final params = FetchPopularPeopleParams(pageNo: currentPageNo);
      final result = await fetchPopularPeopleUsecase(params);
      result.fold(
          (failure) => emit(
              FetchPopularPersonsFailedState(failureMessage: failure.message)),
          (success) {
        currentPageNo = success.pageNo;
        emit(FetchPopularPersonsSuccessState(personsList: success.personsList));
      });
    });
  }
}
