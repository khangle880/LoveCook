import '../../core/base/base_response.dart';

class UploadModel extends BaseResponse {
  final List<String>? urls;

  UploadModel({this.urls});

  UploadModel copyWith({List<String>? urls}) {
    return UploadModel(urls: urls ?? this.urls);
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return UploadModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {'urls': urls};
  }

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      urls: List<String>.from(json['urls']),
    );
  }
  @override
  String toString() {
    return 'UploadModel(urls: $urls)';
  }

  @override
  List<Object?> get props => [urls];
}
