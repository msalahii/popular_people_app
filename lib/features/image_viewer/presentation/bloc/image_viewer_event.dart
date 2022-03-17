part of 'image_viewer_bloc.dart';

abstract class ImageViewerEvent extends Equatable {
  const ImageViewerEvent();

  @override
  List<Object> get props => [];
}

class DownloadImageEvent extends ImageViewerEvent {
  final String imageURL;

  const DownloadImageEvent({required this.imageURL});
}
