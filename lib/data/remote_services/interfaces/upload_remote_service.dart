import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../../data/responses/responses.dart';

abstract class IUploadRemoteService {
  Future<bool> uploadFile({
    required String fileName,
    required String filePath,
  });

  Future<bool> downloadFile({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
  });

  Future<bool> uploadFileData({
    required Uint8List fileData,
  });
}
