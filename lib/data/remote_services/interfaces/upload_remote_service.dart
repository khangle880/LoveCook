import 'package:dio/dio.dart';

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
    required String filePath,
  });
}
