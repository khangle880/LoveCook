import 'package:equatable/equatable.dart';

import '../../data/data.dart';
import '../../data/enum.dart';

class AddRecipeState extends Equatable {
  final bool? success;
  final String? error;
  final LookupModel? lookup;
  final String? name;
  final String? description;
  final int? servings;
  final double? totalTime;
  final Level? level;
  final List<IngredientModel>? ingredients;
  final List<CookStepModel>? steps;
  final List<SpecialGoalModel>? specialGoals;
  final List<MenuTypeModel>? menuTypes;
  final CuisineModel? cuisine;
  final DishTypeModel? dishType;
  final CookMethodModel? cookMethod;
  final List<String>? photoUrls;
  final String? videoUrl;
  final String? videoThumbnail;
  final String? id;
  AddRecipeState({
    this.id,
    this.success,
    this.error,
    this.lookup,
    this.name,
    this.description,
    this.photoUrls,
    this.servings,
    this.steps,
    this.totalTime,
    this.level,
    this.videoUrl,
    this.videoThumbnail,
    this.ingredients,
    this.specialGoals,
    this.menuTypes,
    this.cuisine,
    this.dishType,
    this.cookMethod,
  });

  AddRecipeState copyWith({
    bool? success,
    String? error,
    LookupModel? lookup,
    String? name,
    String? description,
    int? servings,
    double? totalTime,
    Level? level,
    List<IngredientModel>? ingredients,
    List<CookStepModel>? steps,
    List<SpecialGoalModel>? specialGoals,
    List<MenuTypeModel>? menuTypes,
    CuisineModel? cuisine,
    DishTypeModel? dishType,
    CookMethodModel? cookMethod,
    List<String>? photoUrls,
    String? videoUrl,
    String? videoThumbnail,
    String? id,
  }) {
    return AddRecipeState(
      success: success ?? this.success,
      error: error ?? this.error,
      lookup: lookup ?? this.lookup,
      name: name ?? this.name,
      description: description ?? this.description,
      servings: servings ?? this.servings,
      totalTime: totalTime ?? this.totalTime,
      level: level ?? this.level,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      specialGoals: specialGoals ?? this.specialGoals,
      menuTypes: menuTypes ?? this.menuTypes,
      cuisine: cuisine ?? this.cuisine,
      dishType: dishType ?? this.dishType,
      cookMethod: cookMethod ?? this.cookMethod,
      photoUrls: photoUrls ?? this.photoUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props {
    return [
      success,
      error,
      lookup,
      name,
      description,
      servings,
      totalTime,
      level,
      ingredients,
      steps,
      specialGoals,
      menuTypes,
      cuisine,
      dishType,
      cookMethod,
      photoUrls,
      videoUrl,
      videoThumbnail,
      id,
    ];
  }
}
