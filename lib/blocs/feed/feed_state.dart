import 'package:equatable/equatable.dart';

import '../../data/models/login_model.dart';

class FeedState extends Equatable {
  final User? user;
  final String? query;
  FeedState({
    this.user,
    this.query,
  });

  @override
  List<Object?> get props => [user, query];

  FeedState copyWith({
    User? user,
    String? query,
  }) {
    return FeedState(
      user: user ?? this.user,
      query: query ?? this.query,
    );
  }
}
