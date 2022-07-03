import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool? success;
  final String? error;

  RegisterState({
    RegisterState? state,
    bool? success,
    String? error,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
