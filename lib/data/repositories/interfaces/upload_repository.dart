import 'package:dartz/dartz.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class IUploadRepository {
  Future<Either<Failure, SingleResponse<UploadModel>>> uploadVideoData(
      {required String filePath});

  Future<Either<Failure, SingleResponse<UploadModel>>> uploadFileData(
      {required String filePath});
}
