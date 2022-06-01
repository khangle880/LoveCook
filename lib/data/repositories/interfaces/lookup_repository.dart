import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

import '../../../core/core.dart';

abstract class ILookupRepository {
  Future<Either<Failure, PagingListResponse<SpecialGoalModel>>>
      getSpecialGoals();
  Future<Either<Failure, PagingListResponse<MenuTypeModel>>>
      getMenuTypes();
  Future<Either<Failure, PagingListResponse<CuisineModel>>>
      getCuisines();
  Future<Either<Failure, PagingListResponse<DishTypeModel>>>
      getDishTypes();
  Future<Either<Failure, PagingListResponse<IngredientModel>>>
      getIngredients();
  Future<Either<Failure, PagingListResponse<ProductTypeModel>>>
      getProductTypes();
  Future<Either<Failure, PagingListResponse<UnitModel>>>
      getUnits();
  Future<Either<Failure, PagingListResponse<CookMethodModel>>>
      getCookMethods();
}
