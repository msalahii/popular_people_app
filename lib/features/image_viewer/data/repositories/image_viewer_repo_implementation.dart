import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/image_viewer_repo.dart';

class ImageViewerRepositoryImplementation extends ImageViewerRepository {
  final NetworkInfo networkInfo;

  ImageViewerRepositoryImplementation({required this.networkInfo});

  @override
  Future<Either<Failure, String>> downloadImage(String imageURL) async {
    String? imageID;
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return Left(InternetFailure());
      }
      imageID = await ImageDownloader.downloadImage(imageURL);
    } on PlatformException catch (_) {
      return Left(ServerFailure(failureMessage: 'Unexpected Error'));
    } catch (e) {
      return Left(InternetFailure());
    }
    
    return imageID == null ? Left(MissingPermissionFailure()) : Right(imageID);
  }
}
