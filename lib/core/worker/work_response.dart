class WorkResponse {
  final int? statusCode;
  final String? statusMessage;
  final dynamic data;

  WorkResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });
}
