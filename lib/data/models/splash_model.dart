import 'dart:convert';

class SplashModel {
  final String? data;
  SplashModel({
    this.data,
  });

  SplashModel copyWith({
    String? data,
  }) {
    return SplashModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory SplashModel.fromMap(Map<String, dynamic> map) {
    return SplashModel(
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SplashModel.fromJson(String source) => SplashModel.fromMap(json.decode(source));

  @override
  String toString() => 'SplashModel(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SplashModel && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
