import 'dart:developer';

import 'package:dio/dio.dart';

abstract class INetworkUtility {
  Future<Response> request(
    String url,
    Method method, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  });
}

class NetworkUtility implements INetworkUtility {
  late Dio _dio;

  final String baseUrl;
  final List<Interceptor>? interceptors;
  final ResponseType responseType;

  NetworkUtility(
    this.baseUrl, {
    this.interceptors,
    this.responseType = ResponseType.plain,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    int sendTimeout = 30000,
  }) {
    print(baseUrl);
    BaseOptions _options = BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      responseType: responseType,
      headers: {},
      validateStatus: (_) {
        return true;
      },
      baseUrl: baseUrl,
    );
    _dio = Dio(_options);

    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors!);
    }
  }

  Future<Response> _createRequest(
    String method,
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    log(url);

    options ??= Options(headers: {});
    options.method = method;

    var response;
    try {
      response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      print("NetworkUtility: ${e.toString()}");
    }
    return response;
  }

  @override
  Future<Response> request(
    String url,
    Method method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await _createRequest(
      method.value,
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }
}

enum ErrorCode {
  TIME_OUT,
  UNKNOWN,
}

enum Method {
  POST,
  PUT,
  DELETE,
  GET,
}

extension MethodExtensions on Method {
  String get value => ['POST', 'PUT', 'DELETE', 'GET'][index];
}

extension ErrorCodeExtensions on ErrorCode {
  String get value => ['time_out', 'unknown'][index];
}
