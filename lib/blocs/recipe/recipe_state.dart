import 'package:equatable/equatable.dart';

class RecipeState extends Equatable {
  final bool? success;
  final String? error;
  RecipeState({
    bool? success,
    String? error,
    RecipeState? state,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
