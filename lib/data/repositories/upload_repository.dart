import 'dart:typed_data';
import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../data.dart';

class UploadRepository extends IUploadRepository {
  final IUploadRemoteService remoteService;

  UploadRepository(this.remoteService);

  @override
  Future<Either<Failure, bool>> uploadFileData({
    required Uint8List fileData,
  }) async {
    try {
      final result = await remoteService.uploadFileData(
        fileData: fileData,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
