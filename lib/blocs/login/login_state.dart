import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool? success;
  final String? error;

  LoginState({
    LoginState? state,
    bool? success,
    String? error,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
