import '../../../core/base/base_response.dart';
import '../../data.dart';

abstract class ILookupRemoteService {
  Future<PagingListResponse<SpecialGoalModel>> getSpecialGoals();
  Future<PagingListResponse<MenuTypeModel>> getMenuTypes();
  Future<PagingListResponse<CuisineModel>> getCuisines();
  Future<PagingListResponse<DishTypeModel>> getDishTypes();
  Future<PagingListResponse<IngredientTypeModel>> getIngredients();
  Future<PagingListResponse<ProductTypeModel>> getProductTypes();
  Future<PagingListResponse<UnitModel>> getUnits();
  Future<PagingListResponse<CookMethodModel>> getCookMethods();
}
