import 'package:dio/dio.dart';

import '../../../core/base/base_response.dart';
import '../../data.dart';

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

  Future<SingleResponse<UploadModel>> uploadVideoData({
    required String filePath,
  });

  Future<SingleResponse<UploadModel>> uploadFileData({
    required String filePath,
  });
}
