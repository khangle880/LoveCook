import 'package:equatable/equatable.dart';

class AddRecipeState extends Equatable {
  final bool? success;
  final String? error;

  AddRecipeState({
    bool? success,
    String? error,
    AddRecipeState? state,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
