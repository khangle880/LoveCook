
import 'package:equatable/equatable.dart';

import '../../core/base/base_response.dart';

class SpecialGoalModel extends BaseResponse with EquatableMixin {
  final String? id;
  final List<String>? names;
  SpecialGoalModel({
    this.id,
    this.names,
  });

  SpecialGoalModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return SpecialGoalModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  @override
  String toString() => 'SpecialGoalModel(id: $id, names: $names)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return SpecialGoalModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory SpecialGoalModel.fromJson(Map<String, dynamic> json) {
    return SpecialGoalModel(
      id: json['id'] ?? '',
      names: List<String>.from(json['names']),
    );
  }

  @override
  List<Object?> get props => [id, names];
}

class MenuTypeModel extends BaseResponse {
  final String? id;
  final List<String>? names;
  MenuTypeModel({
    this.id,
    this.names,
  });

  MenuTypeModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return MenuTypeModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  @override
  String toString() => 'MenuTypeModel(id: $id, names: $names)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return MenuTypeModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory MenuTypeModel.fromJson(Map<String, dynamic> json) {
    return MenuTypeModel(
      id: json['id'] ?? '',
      names: List<String>.from(json['names']),
    );
  }

  @override
  List<Object?> get props => [id, names];
}

class CuisineModel extends BaseResponse {
  final String? id;
  final List<String>? names;
  CuisineModel({
    this.id,
    this.names,
  });

  CuisineModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return CuisineModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  @override
  String toString() => 'CuisineModel(id: $id, names: $names)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return CuisineModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
      id: json['id'] ?? '',
      names: List<String>.from(json['names']),
    );
  }

  @override
  List<Object?> get props => [id, names];
}

class DishTypeModel extends BaseResponse with EquatableMixin {
  final String? id;
  final List<String>? names;
  DishTypeModel({
    this.id,
    this.names,
  });

  DishTypeModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return DishTypeModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  @override
  String toString() => 'DishTypeModel(id: $id, names: $names)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return DishTypeModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory DishTypeModel.fromJson(Map<String, dynamic> json) {
    return DishTypeModel(
      id: json['id'] ?? '',
      names: List<String>.from(json['names']),
    );
  }

  @override
  List<Object?> get props => [id, names];
}

class IngredientTypeModel extends BaseResponse {
  final String? id;
  final List<String>? names;
  IngredientTypeModel({
    this.id,
    this.names,
  });

  IngredientTypeModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return IngredientTypeModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  @override
  String toString() => 'IngredientTypeModel(id: $id, names: $names)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return IngredientTypeModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory IngredientTypeModel.fromJson(Map<String, dynamic> json) {
    return IngredientTypeModel(
      id: json['id'] ?? '',
      names: List<String>.from(json['names']),
    );
  }

  @override
  List<Object?> get props => [id, names];
}

class ProductTypeModel extends BaseResponse {
  final String? id;
  final List<String>? names;
  ProductTypeModel({
    this.id,
    this.names,
  });

  ProductTypeModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return ProductTypeModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  @override
  String toString() => 'ProductTypeModel(id: $id, names: $names)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return ProductTypeModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'] ?? '',
      names: List<String>.from(json['names']),
    );
  }

  @override
  List<Object?> get props => [id, names];
}

class UnitModel extends BaseResponse {
  final String? id;
  final String? name;
  UnitModel({
    this.id,
    this.name,
  });

  UnitModel copyWith({
    String? id,
    String? name,
  }) {
    return UnitModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'UnitModel(id: $id, name: $name)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return UnitModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
  
  @override
  List<Object?> get props => [id, name];
}

class CookMethodModel extends BaseResponse {
  final String? id;
  final List<String>? names;
  CookMethodModel({
    this.id,
    this.names,
  });

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return CookMethodModel.fromJson(json) as T;
  }

  CookMethodModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return CookMethodModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory CookMethodModel.fromJson(Map<String, dynamic> json) {
    return CookMethodModel(
      id: json['id'],
      names: List<String>.from(json['names']),
    );
  }

  @override
  String toString() => 'CookMethodModel(id: $id, names: $names)';

  @override
  List<Object?> get props => [id, names];
}

class LookupModel extends BaseResponse {
  final List<SpecialGoalModel>? goals;
  final List<MenuTypeModel>? menuTypes;
  final List<CuisineModel>? cuisines;
  final List<DishTypeModel>? dishTypes;
  final List<IngredientTypeModel>? ingredientTypes;
  final List<ProductTypeModel>? productTypes;
  final List<UnitModel>? units;
  final List<CookMethodModel>? cookMethods;
  LookupModel({
    this.goals,
    this.menuTypes,
    this.cuisines,
    this.dishTypes,
    this.ingredientTypes,
    this.productTypes,
    this.units,
    this.cookMethods,
  });

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return LookupModel.fromJson(json) as T;
  }

  LookupModel copyWith({
    List<SpecialGoalModel>? goals,
    List<MenuTypeModel>? menuTypes,
    List<CuisineModel>? cuisines,
    List<DishTypeModel>? dishTypes,
    List<IngredientTypeModel>? ingredientTypes,
    List<ProductTypeModel>? productTypes,
    List<UnitModel>? units,
    List<CookMethodModel>? cookMethods,
  }) {
    return LookupModel(
      goals: goals ?? this.goals,
      menuTypes: menuTypes ?? this.menuTypes,
      cuisines: cuisines ?? this.cuisines,
      dishTypes: dishTypes ?? this.dishTypes,
      ingredientTypes: ingredientTypes ?? this.ingredientTypes,
      productTypes: productTypes ?? this.productTypes,
      units: units ?? this.units,
      cookMethods: cookMethods ?? this.cookMethods,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goals': goals?.map((x) => x.toJson()).toList(),
      'menuTypes': menuTypes?.map((x) => x.toJson()).toList(),
      'cuisines': cuisines?.map((x) => x.toJson()).toList(),
      'dishTypes': dishTypes?.map((x) => x.toJson()).toList(),
      'ingredientTypes': ingredientTypes?.map((x) => x.toJson()).toList(),
      'productTypes': productTypes?.map((x) => x.toJson()).toList(),
      'units': units?.map((x) => x.toJson()).toList(),
      'cookMethods': cookMethods?.map((x) => x.toJson()).toList(),
    };
  }

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    return LookupModel(
      goals: json['goals'] != null
          ? List<SpecialGoalModel>.from(
              json['goals']?.map((x) => SpecialGoalModel.fromJson(x)))
          : null,
      menuTypes: json['menuTypes'] != null
          ? List<MenuTypeModel>.from(
              json['menuTypes']?.map((x) => MenuTypeModel.fromJson(x)))
          : null,
      cuisines: json['cuisines'] != null
          ? List<CuisineModel>.from(
              json['cuisines']?.map((x) => CuisineModel.fromJson(x)))
          : null,
      dishTypes: json['dishTypes'] != null
          ? List<DishTypeModel>.from(
              json['dishTypes']?.map((x) => DishTypeModel.fromJson(x)))
          : null,
      ingredientTypes: List<IngredientTypeModel>.from(
          json['ingredientTypes']?.map((x) => IngredientTypeModel.fromJson(x))),
      productTypes: List<ProductTypeModel>.from(
          json['productTypes']?.map((x) => ProductTypeModel.fromJson(x))),
      units: List<UnitModel>.from(
          json['units']?.map((x) => UnitModel.fromJson(x))),
      cookMethods: List<CookMethodModel>.from(
          json['cookMethods']?.map((x) => CookMethodModel.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'LookupModel(goals: $goals, menuTypes: $menuTypes, cuisines: $cuisines, dishTypes: $dishTypes, ingredientTypes: $ingredientTypes, productTypes: $productTypes, units: $units, cookMethods: $cookMethods)';
  }

  @override
  List<Object?> get props => [
        goals,
        menuTypes,
        cuisines,
        dishTypes,
        ingredientTypes,
        productTypes,
        units,
        cookMethods,
      ];
}
