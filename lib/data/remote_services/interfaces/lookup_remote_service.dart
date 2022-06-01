import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

abstract class ILookupRemoteService {
  Future<PagingListResponse<SpecialGoalModel>> getSpecialGoals();
  Future<PagingListResponse<MenuTypeModel>> getMenuTypes();
  Future<PagingListResponse<CuisineModel>> getCuisines();
  Future<PagingListResponse<DishTypeModel>> getDishTypes();
  Future<PagingListResponse<IngredientModel>> getIngredients();
  Future<PagingListResponse<ProductTypeModel>> getProductTypes();
  Future<PagingListResponse<UnitModel>> getUnits();
  Future<PagingListResponse<CookMethodModel>> getCookMethods();
}
