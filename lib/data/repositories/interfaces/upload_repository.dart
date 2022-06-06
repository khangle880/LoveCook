import 'package:dartz/dartz.dart';

import '../../../core/core.dart';

abstract class IUploadRepository {
  Future<Either<Failure, bool>> uploadFileData({required String filePath});
}
