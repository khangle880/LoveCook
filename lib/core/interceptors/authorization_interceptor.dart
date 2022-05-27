import 'dart:core';
import 'package:dio/dio.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] = 'Bearer DUMMY_TOKEN_HERE';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // mapping error message HERE
    super.onResponse(response, handler);
  }
}
