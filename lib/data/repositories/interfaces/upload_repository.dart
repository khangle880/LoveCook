import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../../data/responses/responses.dart';

abstract class IUploadRepository {
  Future<Either<Failure, bool>> uploadFileData({required Uint8List fileData});
}
