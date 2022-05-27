import '../core.dart';

class WorkRequest {
  final String baseUrl;
  final String enpoint;
  final Method method;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? params;

  WorkRequest({
    required this.baseUrl,
    required this.enpoint,
    required this.method,
    this.data,
    this.params,
  });
}
