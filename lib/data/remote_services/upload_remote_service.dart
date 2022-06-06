import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class UploadRemoteService implements IUploadRemoteService {
  late final INetworkUtility _networkUtility;

  UploadRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<bool> uploadFile({
    required String fileName,
    required String filePath,
  }) {
    return Future.value(false);
  }

  @override
  Future<bool> downloadFile({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
  }) {
    return Future.value(false);
  }

  @override
  Future<bool> uploadFileData({
    required Uint8List fileData,
  }) async {
    final multipartFile = MultipartFile.fromBytes(fileData);
    FormData formData = FormData.fromMap({
      "file": multipartFile,
    });

    final response = await _networkUtility.request(
      'v1/photos',
      Method.POST,
      data: formData,
    );

    print(response.data);

    return Future.value(true);
  }
}
