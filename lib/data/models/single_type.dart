import '../../core/base/base_response.dart';

class SingleType extends BaseResponse {
  final dynamic value;
  SingleType({
    required this.value,
  });

  SingleType copyWith({
    dynamic value,
  }) {
    return SingleType(
      value: value ?? this.value,
    );
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
}
