import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/download_image_usecase.dart';
part 'image_viewer_event.dart';
part 'image_viewer_state.dart';

class ImageViewerBloc extends Bloc<ImageViewerEvent, ImageViewerState> {
  final DownloadImageUsecase downloadImageUsecase;
  ImageViewerBloc({required this.downloadImageUsecase})
      : super(ImageViewerInitial()) {
    on<DownloadImageEvent>((event, emit) async {
      emit(DownloadImageLoadingState());
      final params = DownloadImageParams(imageURL: event.imageURL);
      final result = await downloadImageUsecase(params);
      result.fold(
          (failure) =>
              emit(DownloadImageFailedState(failureMessage: failure.message)),
          (success) => emit(DownloadImageSuccessState(imageID: success)));
    });
  }
}
