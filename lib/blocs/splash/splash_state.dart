import 'package:equatable/equatable.dart';

enum SplashStatus {
  authenticated,
  loading_data,
  not_authenticated,
}

class SplashState extends Equatable {
  final bool? success;
  final String? error;
  final SplashStatus? status;

  SplashState({
    SplashState? state,
    bool? success,
    String? error,
    SplashStatus? status,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        status = status ?? state?.status;

  @override
  List<Object?> get props => [success, error];
}
