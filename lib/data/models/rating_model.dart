import 'package:lovecook/core/base/base_response.dart';

import 'models.dart';

class RatingModel extends BaseResponse {
  final User? user;
  final double? point;
  RatingModel({
    this.user,
    this.point,
  });

  RatingModel copyWith({
    User? user,
    double? point,
  }) {
    return RatingModel(
      user: user ?? this.user,
      point: point ?? this.point,
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return RatingModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'point': point,
    };
  }

  factory RatingModel.fromJson(Map<String, dynamic> map) {
    return RatingModel(
      user: map['user'] != null ? User.fromJson(map['user']) : null,
      point: map['point']?.toDouble(),
    );
  }
  @override
  String toString() => 'RatingModel(user: $user, point: $point)';
}
