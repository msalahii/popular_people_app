import 'package:popular_people_app/dependencies/service_locator.dart';
import '../features/image_viewer/data/repositories/image_viewer_repo_implementation.dart';
import '../features/image_viewer/domain/repositories/image_viewer_repo.dart';
import '../features/image_viewer/domain/usecases/download_image_usecase.dart';
import '../features/image_viewer/presentation/bloc/image_viewer_bloc.dart';

class ImageViewerContainer extends ServiceLocator {
  ImageViewerContainer() {
    init();
  }

  @override
  void init() {
    serviceLocator.registerFactory(
        () => ImageViewerBloc(downloadImageUsecase: serviceLocator()));

    serviceLocator
        .registerLazySingleton(() => DownloadImageUsecase(serviceLocator()));

    serviceLocator.registerLazySingleton<ImageViewerRepository>(() =>
        ImageViewerRepositoryImplementation(networkInfo: serviceLocator()));
  }
}
