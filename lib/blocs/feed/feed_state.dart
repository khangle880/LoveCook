import 'package:equatable/equatable.dart';

import '../../data/models/login_model.dart';

class FeedState extends Equatable {
  final User? user;
  FeedState({
    this.user,
  });

  FeedState copyWith({
    User? user,
  }) {
    return FeedState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
