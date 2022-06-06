import 'package:dartz/dartz.dart';
import '../../../core/base/base_response.dart';
import '../../data.dart';

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
  Future<Either<Failure, PagingListResponse<IngredientTypeModel>>>
      getIngredients();
  Future<Either<Failure, PagingListResponse<ProductTypeModel>>>
      getProductTypes();
  Future<Either<Failure, PagingListResponse<UnitModel>>>
      getUnits();
  Future<Either<Failure, PagingListResponse<CookMethodModel>>>
      getCookMethods();
}
