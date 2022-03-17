import 'package:popular_people_app/dependencies/service_locator.dart';
import '../features/person_details/data/datasources/person_details_remote_data_source.dart';
import '../features/person_details/data/repositories/person_details_repo_implementation.dart';
import '../features/person_details/domain/repositories/person_details_repo.dart';
import '../features/person_details/domain/usecases/fetch_person_images_usecase.dart';
import '../features/person_details/presentation/bloc/person_details_bloc.dart';

class PersonDetailsContainer extends ServiceLocator {
  PersonDetailsContainer() {
    init();
  }

  @override
  void init() {
    serviceLocator.registerFactory(
        () => PersonDetailsBloc(fetchPersonImagesUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton(
        () => FetchPersonImagesUsecase(serviceLocator()));

    serviceLocator.registerLazySingleton<PersonDetailsRepository>(() =>
        PersonDetailsRepositoryImplementation(
            remoteDataSource: serviceLocator(), networkInfo: serviceLocator()));

    serviceLocator.registerLazySingleton<PersonDetailsRemoteDataSource>(() =>
        PersonDetailsRemoteDataSourceImplementation(client: serviceLocator()));
  }
}
