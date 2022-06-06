import 'package:equatable/equatable.dart';

import '../../core/base/base_response.dart';
import '../enum.dart';
import 'models.dart';

class IngredientModel {
  final String? id;
  final String? name;
  final IngredientTypeModel? type;
  final UnitModel? unit;
  final double? quantity;
  IngredientModel({
    this.id,
    this.name,
    this.type,
    this.unit,
    this.quantity,
  });

  IngredientModel copyWith({
    String? id,
    String? name,
    IngredientTypeModel? type,
    UnitModel? unit,
    double? quantity,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type?.toJson(),
      'unit': unit?.toJson(),
      'quantity': quantity,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'],
      name: json['name'],
      type: json['type'] != null
          ? IngredientTypeModel.fromJson(json['type'])
          : null,
      unit: json['unit'] != null ? UnitModel.fromJson(json['unit']) : null,
      quantity: json['quantity']?.toDouble(),
    );
  }

  @override
  String toString() {
    return 'IngredientModel(id: $id, name: $name, type: $type, unit: $unit, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IngredientModel &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.unit == unit &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        unit.hashCode ^
        quantity.hashCode;
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

class RecipeModel extends BaseResponse with EquatableMixin {
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
  final String? videoThumbnail;
  final List<IngredientModel>? ingredients;
  final List<SpecialGoalModel>? specialGoals;
  final List<MenuTypeModel>? menuTypes;
  final CuisineModel? cuisine;
  final DishTypeModel? dishType;
  final CookMethodModel? cookMethod;
  final int? totalLikes;
  final int? totalCooks;
  final int? totalRatings;
  final bool? isLiked;
  final bool? isCooked;
  final bool? idVoted;
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
    this.videoThumbnail,
    this.ingredients,
    this.specialGoals,
    this.menuTypes,
    this.cuisine,
    this.dishType,
    this.cookMethod,
    this.totalLikes,
    this.totalCooks,
    this.totalRatings,
    this.isLiked,
    this.isCooked,
    this.idVoted,
  });

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
      'videoThumbnail': videoThumbnail,
      'ingredients': ingredients?.map((x) => x.toJson()).toList(),
      'specialGoals': specialGoals?.map((x) => x.toJson()).toList(),
      'menuTypes': menuTypes?.map((x) => x.toJson()).toList(),
      'cuisine': cuisine?.toJson(),
      'dishType': dishType?.toJson(),
      'cookMethod': cookMethod?.toJson(),
      'totalLikes': totalLikes,
      'totalCooks': totalCooks,
      'totalRatings': totalRatings,
      'isLiked': isLiked,
      'isCooked': isCooked,
      'idVoted': idVoted,
    };
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
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
      videoThumbnail: json['videoThumbnail'],
      ingredients: json['ingredients'] != null
          ? List<IngredientModel>.from(
              json['ingredients']?.map((x) => IngredientModel.fromJson(x)))
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
      cookMethod: json['cookMethod'] != null
          ? CookMethodModel.fromJson(json['cookMethod'])
          : null,
      totalLikes: json['totalLikes']?.toInt(),
      totalCooks: json['totalCooks']?.toInt(),
      totalRatings: json['totalRatings']?.toInt(),
      isLiked: json['isLiked'],
      isCooked: json['isCooked'],
      idVoted: json['idVoted'],
    );
  }

  @override
  String toString() {
    return 'RecipeModel(id: $id, creator: $creator, description: $description, name: $name, photoUrls: $photoUrls, servings: $servings, steps: $steps, totalTime: $totalTime, totalView: $totalView, level: $level, videoUrl: $videoUrl, videoThumbnail: $videoThumbnail, ingredients: $ingredients, specialGoals: $specialGoals, menuTypes: $menuTypes, cuisine: $cuisine, dishType: $dishType, cookMethod: $cookMethod, totalLikes: $totalLikes, totalCooks: $totalCooks, totalRatings: $totalRatings, isLiked: $isLiked, isCooked: $isCooked, idVoted: $idVoted)';
  }

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
    String? videoThumbnail,
    List<IngredientModel>? ingredients,
    List<SpecialGoalModel>? specialGoals,
    List<MenuTypeModel>? menuTypes,
    CuisineModel? cuisine,
    DishTypeModel? dishType,
    CookMethodModel? cookMethod,
    int? totalLikes,
    int? totalCooks,
    int? totalRatings,
    bool? isLiked,
    bool? isCooked,
    bool? idVoted,
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
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      ingredients: ingredients ?? this.ingredients,
      specialGoals: specialGoals ?? this.specialGoals,
      menuTypes: menuTypes ?? this.menuTypes,
      cuisine: cuisine ?? this.cuisine,
      dishType: dishType ?? this.dishType,
      cookMethod: cookMethod ?? this.cookMethod,
      totalLikes: totalLikes ?? this.totalLikes,
      totalCooks: totalCooks ?? this.totalCooks,
      totalRatings: totalRatings ?? this.totalRatings,
      isLiked: isLiked ?? this.isLiked,
      isCooked: isCooked ?? this.isCooked,
      idVoted: idVoted ?? this.idVoted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        creator,
        description,
        name,
        photoUrls,
        servings,
        steps,
        totalTime,
        totalView,
        level,
        videoUrl,
        videoThumbnail,
        ingredients,
        specialGoals,
        menuTypes,
        cuisine,
        dishType,
        cookMethod,
        totalLikes,
        totalCooks,
        totalRatings,
        isLiked,
        isCooked,
        idVoted
      ];
}
