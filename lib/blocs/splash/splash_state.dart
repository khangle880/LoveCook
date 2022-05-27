import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final bool? success;
  final String? error;

  SplashState({
    SplashState? state,
    bool? success,
    String? error,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
