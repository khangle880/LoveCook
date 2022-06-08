import 'package:equatable/equatable.dart';

class FeedCommentState extends Equatable {
  final bool? success;
  final String? error;

  FeedCommentState({
    FeedCommentState? state,
    bool? success,
    String? error,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
