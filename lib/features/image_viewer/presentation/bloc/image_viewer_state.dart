part of 'image_viewer_bloc.dart';

abstract class ImageViewerState extends Equatable {
  const ImageViewerState();

  @override
  List<Object> get props => [];
}

class ImageViewerInitial extends ImageViewerState {}

class DownloadImageLoadingState extends ImageViewerState {}

class DownloadImageFailedState extends ImageViewerState {
  final String failureMessage;

  const DownloadImageFailedState({required this.failureMessage});
}

class DownloadImageSuccessState extends ImageViewerState {
  final String imageID;

  const DownloadImageSuccessState({required this.imageID});
}
