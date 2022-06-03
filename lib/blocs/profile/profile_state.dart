import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class ProfileState extends Equatable {
  final bool? success;
  final bool? error;
  final User? user;

  ProfileState({
    ProfileState? state,
    bool? success,
    bool? error,
    User? user,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        user = user ?? state?.user;

  @override
  List<Object?> get props => [success, error, user];
}
