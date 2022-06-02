import '../../core/base/base_response.dart';

import '../enum.dart';

import 'models.dart';

class IngredientInRecipeModel {
  final String? id;
  final IngredientModel? ingredient;
  final UnitModel? unit;
  final double? quantity;
  IngredientInRecipeModel({
    this.id,
    this.ingredient,
    this.unit,
    this.quantity,
  });

  IngredientInRecipeModel copyWith({
    String? id,
    IngredientModel? ingredient,
    UnitModel? unit,
    double? quantity,
  }) {
    return IngredientInRecipeModel(
      id: id ?? this.id,
      ingredient: ingredient ?? this.ingredient,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingredient': ingredient?.toJson(),
      'unit': unit?.toJson(),
      'quantity': quantity,
    };
  }

  factory IngredientInRecipeModel.fromJson(Map<String, dynamic> json) {
    return IngredientInRecipeModel(
      id: json['id'] ?? '',
      ingredient: json['ingredient'] != null
          ? IngredientModel.fromJson(json['ingredient'])
          : null,
      unit: json['unit'] != null ? UnitModel.fromJson(json['unit']) : null,
      quantity: json['quantity']?.toDouble(),
    );
  }
}

class CookStepModel {
  final String? content;
  final List<String>? photoUrls;
  CookStepModel({
    this.content,
    this.photoUrls,
  });

  @override
  String toString() => 'CookStep(content: $content, photoUrls: $photoUrls)';

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'photoUrls': photoUrls,
    };
  }

  factory CookStepModel.fromJson(Map<String, dynamic> json) {
    return CookStepModel(
      content: json['content'],
      photoUrls: List<String>.from(json['photoUrls']),
    );
  }
}

class RecipeModel extends BaseResponse {
  final String? id;
  final User? creator;
  final String? description;
  final String? name;
  final List<String>? photoUrls;
  final int? servings;
  final List<CookStepModel>? steps;
  final double? totalTime;
  final double? totalView;
  final Level? level;
  final String? videoUrl;
  final List<IngredientInRecipeModel>? ingredients;
  final List<SpecialGoalModel>? specialGoals;
  final List<MenuTypeModel>? menuTypes;
  final CuisineModel? cuisine;
  final DishTypeModel? dishType;
  RecipeModel({
    this.id,
    this.creator,
    this.description,
    this.name,
    this.photoUrls,
    this.servings,
    this.steps,
    this.totalTime,
    this.totalView,
    this.level,
    this.videoUrl,
    this.ingredients,
    this.specialGoals,
    this.menuTypes,
    this.cuisine,
    this.dishType,
  });

  RecipeModel copyWith({
    String? id,
    User? creator,
    String? description,
    String? name,
    List<String>? photoUrls,
    int? servings,
    List<CookStepModel>? steps,
    double? totalTime,
    double? totalView,
    Level? level,
    String? videoUrl,
    List<IngredientInRecipeModel>? ingredients,
    List<SpecialGoalModel>? specialGoals,
    List<MenuTypeModel>? menuTypes,
    CuisineModel? cuisine,
    DishTypeModel? dishType,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      description: description ?? this.description,
      name: name ?? this.name,
      photoUrls: photoUrls ?? this.photoUrls,
      servings: servings ?? this.servings,
      steps: steps ?? this.steps,
      totalTime: totalTime ?? this.totalTime,
      totalView: totalView ?? this.totalView,
      level: level ?? this.level,
      videoUrl: videoUrl ?? this.videoUrl,
      ingredients: ingredients ?? this.ingredients,
      specialGoals: specialGoals ?? this.specialGoals,
      menuTypes: menuTypes ?? this.menuTypes,
      cuisine: cuisine ?? this.cuisine,
      dishType: dishType ?? this.dishType,
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return RecipeModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator?.toJson(),
      'description': description,
      'name': name,
      'photoUrls': photoUrls,
      'servings': servings,
      'steps': steps?.map((x) => x.toJson()).toList(),
      'totalTime': totalTime,
      'totalView': totalView,
      'level': level?.shortString,
      'videoUrl': videoUrl,
      'ingredients': ingredients?.map((x) => x.toJson()).toList(),
      'specialGoals': specialGoals?.map((x) => x.toJson()).toList(),
      'menuTypes': menuTypes?.map((x) => x.toJson()).toList(),
      'cuisine': cuisine?.toJson(),
      'dishType': dishType?.toJson(),
    };
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] ?? '',
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      description: json['description'],
      name: json['name'],
      photoUrls: List<String>.from(json['photoUrls']),
      servings: json['servings']?.toInt(),
      steps: json['steps'] != null
          ? List<CookStepModel>.from(
              json['steps']?.map((x) => CookStepModel.fromJson(x)))
          : null,
      totalTime: json['totalTime']?.toDouble(),
      totalView: json['totalView']?.toDouble(),
      level: json['level'] != null
          ? enumFromString(Level.values, json['level'])
          : null,
      videoUrl: json['videoUrl'],
      ingredients: json['ingredients'] != null
          ? List<IngredientInRecipeModel>.from(json['ingredients']
              ?.map((x) => IngredientInRecipeModel.fromJson(x)))
          : null,
      specialGoals: json['specialGoals'] != null
          ? List<SpecialGoalModel>.from(
              json['specialGoals']?.map((x) => SpecialGoalModel.fromJson(x)))
          : null,
      menuTypes: json['menuTypes'] != null
          ? List<MenuTypeModel>.from(
              json['menuTypes']?.map((x) => MenuTypeModel.fromJson(x)))
          : null,
      cuisine: json['cuisine'] != null
          ? CuisineModel.fromJson(json['cuisine'])
          : null,
      dishType: json['dishType'] != null
          ? DishTypeModel.fromJson(json['dishType'])
          : null,
    );
  }

  @override
  String toString() {
    return 'RecipeModel(id: $id, creator: $creator, description: $description, name: $name, photoUrls: $photoUrls, servings: $servings, steps: $steps, totalTime: $totalTime, totalView: $totalView, level: $level, videoUrl: $videoUrl, ingredients: $ingredients, specialGoals: $specialGoals, menuTypes: $menuTypes, cuisine: $cuisine, dishType: $dishType)';
  }
}
