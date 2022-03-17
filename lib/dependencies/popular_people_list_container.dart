import 'package:popular_people_app/dependencies/service_locator.dart';
import '../features/popular_people_list/data/datasources/popular_people_local_data_source.dart';
import '../features/popular_people_list/data/datasources/popular_people_remote_data_source.dart';
import '../features/popular_people_list/data/repositories/popular_people_repo_implementation.dart';
import '../features/popular_people_list/domain/repositories/popular_people_repo.dart';
import '../features/popular_people_list/domain/usecases/fetch_popular_people_usecase.dart';
import '../features/popular_people_list/presentation/bloc/popular_people_list_bloc.dart';

class PopularPeopleListContainer implements ServiceLocator {
  PopularPeopleListContainer() {
    init();
  }

  @override
  void init() {
    serviceLocator.registerFactory(() =>
        PopularPeopleListBloc(fetchPopularPeopleUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton(
        () => FetchPopularPeopleUsecase(serviceLocator()));

    serviceLocator.registerLazySingleton<PopularPeopleRepository>(() =>
        PopularPeopleRepositoryImplementation(
            remoteDataSource: serviceLocator(),
            networkInfo: serviceLocator(),
            localDataSource: serviceLocator()));

    serviceLocator.registerLazySingleton<PopularPeopleRemoteDataSource>(() =>
        PopularPeopleRemoteDataSourceImplementation(client: serviceLocator()));

    serviceLocator.registerLazySingleton<PopularPeopleLocalDataSource>(
        () => PopularPeopleLocalDataSourceImplementation());
  }
}
