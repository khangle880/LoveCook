import 'package:lovecook/core/base/base_response.dart';

class SpecialGoalModel extends BaseResponse {
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
}

class DishTypeModel extends BaseResponse {
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
}

class IngredientModel extends BaseResponse {
  final String? id;
  final List<String>? names;
  IngredientModel({
    this.id,
    this.names,
  });

  IngredientModel copyWith({
    String? id,
    List<String>? names,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      names: names ?? this.names,
    );
  }

  @override
  String toString() => 'IngredientModel(id: $id, names: $names)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return IngredientModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'] ?? '',
      names: List<String>.from(json['names']),
    );
  }
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
}

class CookMethodModel extends BaseResponse {
  final String? id;
  final String? name;
  CookMethodModel({
    this.id,
    this.name,
  });

  CookMethodModel copyWith({
    String? id,
    String? name,
  }) {
    return CookMethodModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'CookMethod(id: $id, name: $name)';

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return CookMethodModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CookMethodModel.fromJson(Map<String, dynamic> json) {
    return CookMethodModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
