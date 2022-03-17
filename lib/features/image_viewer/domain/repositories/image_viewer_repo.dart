import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ImageViewerRepository{
  Future<Either<Failure, String>> downloadImage(String imageURL);
}