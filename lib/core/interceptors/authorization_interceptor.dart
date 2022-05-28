import 'dart:core';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extensions/extensions.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(
    this.sharedPreferences,
  );

  final SharedPreferences sharedPreferences;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (sharedPreferences.token != null &&
        sharedPreferences.token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${sharedPreferences.token}';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // mapping error message HERE
    super.onResponse(response, handler);
  }
}
