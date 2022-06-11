import 'package:equatable/equatable.dart';

import 'package:lovecook/data/data.dart';

import '../../data/enum.dart';
import '../../utils/utils.dart';

class RecipeState extends Equatable {
  final bool? success;
  final String? error;
  final Level? level;
  final CuisineModel? cuisine;
  final DishTypeModel? dishType;
  final String? query;
  final LookupModel? lookup;
  final User? user;
  RecipeState({
    this.user,
    this.lookup,
    this.query,
    this.success,
    this.error,
    this.level,
    this.cuisine,
    this.dishType,
  });

  @override
  List<Object?> get props {
    return [success, error, level, cuisine, dishType, query, user];
  }

  RecipeState copyWith({
    LookupModel? lookup,
    Nullable<bool?>? success,
    Nullable<String?>? error,
    Nullable<Level?>? level,
    Nullable<CuisineModel?>? cuisine,
    Nullable<DishTypeModel?>? dishType,
    Nullable<String?>? query,
    User? user,
  }) {
    return RecipeState(
      lookup: lookup ?? this.lookup,
      success: success != null ? success.value : this.success,
      error: error != null ? error.value : this.error,
      level: level != null ? level.value : this.level,
      cuisine: cuisine != null ? cuisine.value : this.cuisine,
      dishType: dishType != null ? dishType.value : this.dishType,
      query: query != null ? query.value : this.query,
      user: user ?? this.user,
    );
  }
}
