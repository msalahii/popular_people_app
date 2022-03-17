import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/image_viewer_repo.dart';

class DownloadImageUsecase extends Usecase<String, DownloadImageParams> {
  final ImageViewerRepository repository;

  DownloadImageUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(params) async {
    var status = Platform.isIOS
        ? await Permission.photos.request()
        : await Permission.storage.request();

    switch (status) {
      case PermissionStatus.limited:
      case PermissionStatus.granted:
        return await repository.downloadImage(params.imageURL);
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        return Left(MissingPermissionFailure());
    }
  }
}

class DownloadImageParams {
  final String imageURL;

  DownloadImageParams({required this.imageURL});
}
