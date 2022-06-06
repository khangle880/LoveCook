import 'package:equatable/equatable.dart';
import 'package:lovecook/data/data.dart';

class RecipeDetailState extends Equatable {
  final bool? success;
  final String? error;
  final RecipeModel? recipe;
  final int? recipesOfCreator;
  RecipeDetailState({
    bool? success,
    String? error,
    RecipeModel? recipe,
    int? recipesOfUser,
    RecipeDetailState? state,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        recipe = recipe ?? state?.recipe,
        recipesOfCreator = recipesOfUser ?? state?.recipesOfCreator;

  @override
  List<Object?> get props => [success, error, recipe, recipesOfCreator];
}
