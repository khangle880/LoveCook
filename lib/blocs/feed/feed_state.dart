import 'package:equatable/equatable.dart';

class FeedState extends Equatable {
  final bool? success;
  final bool? error;

  FeedState({
    FeedState? state,
    bool? success,
    bool? error,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
