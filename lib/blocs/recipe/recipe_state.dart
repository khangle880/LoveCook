import 'package:equatable/equatable.dart';
import 'package:lovecook/data/data.dart';

class RecipeState extends Equatable {
  final bool? success;
  final String? error;
  RecipeState({
    bool? success,
    String? error,
    RecipeState? state,
    List<CommentModel>? comments,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
