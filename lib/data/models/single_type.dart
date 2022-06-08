import '../../core/base/base_response.dart';

class SingleType extends BaseResponse {
  final dynamic value;
  SingleType({
    this.value,
  });

  SingleType copyWith({
    dynamic value,
  }) {
    return SingleType(
      value: value ?? this.value,
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return SingleType.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  factory SingleType.fromJson(Map<String, dynamic> json) {
    return SingleType(
      value: json['value'] ?? null,
    );
  }

  @override
  String toString() => 'SingleType(value: $value)';

  @override
  List<Object?> get props => [value];
}
