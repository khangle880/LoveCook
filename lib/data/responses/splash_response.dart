import '../models/models.dart';

class SplashResponse {
  final String? data;

  SplashResponse({
    this.data,
  });

  factory SplashResponse.fromJson(dynamic json) {
    if (json != null && json is Map) {
      return SplashResponse(
        data: json["data"],
      );
    }
    return SplashResponse();
  }

  SplashModel toModel() => SplashModel(
        data: data,
      );
}
