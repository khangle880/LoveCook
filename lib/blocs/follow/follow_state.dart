import 'package:equatable/equatable.dart';

import '../../data/models/login_model.dart';

class FollowState extends Equatable {
  final User? loggedUser;
  final String? currrentUserId;
  FollowState({
    this.currrentUserId,
    this.loggedUser,
  });

  @override
  List<Object?> get props => [loggedUser, currrentUserId];

  FollowState copyWith({
    User? loggedUser,
    String? currrentUserId,
  }) {
    return FollowState(
      loggedUser: loggedUser ?? this.loggedUser,
      currrentUserId: currrentUserId ?? this.currrentUserId,
    );
  }
}
