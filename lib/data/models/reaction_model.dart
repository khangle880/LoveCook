import '../../core/base/base_response.dart';
import 'models.dart';

class ReactionModel extends BaseResponse {
  final User? user;
  final String? type;
  ReactionModel({
    this.user,
    this.type,
  });

  ReactionModel copyWith({
    User? user,
    String? type,
  }) {
    return ReactionModel(
      user: user ?? this.user,
      type: type ?? this.type,
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return ReactionModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'type': type,
    };
  }

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      type: json['type'],
    );
  }

  @override
  String toString() => 'ReactionModel(user: $user, type: $type)';
}
