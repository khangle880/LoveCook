import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class ProfileState extends Equatable {
  final bool? success;
  final bool? error;
  final User? user;
  final User? loggedUser;

  ProfileState({
    ProfileState? state,
    bool? success,
    bool? error,
    User? user,
    User? loggedUser,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        user = user ?? state?.user,
        loggedUser = loggedUser ?? state?.loggedUser;

  @override
  List<Object?> get props => [success, error, user];
}
