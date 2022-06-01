import 'package:get_it/get_it.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/core/core.dart';
import 'package:lovecook/data/data.dart';

class LookupRemoteService implements ILookupRemoteService {
  late final INetworkUtility _networkUtility;

  LookupRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<PagingListResponse<CuisineModel>> getCuisines() async {
    final response = await _networkUtility
        .request('v1/cuisines', Method.GET, queryParameters: {'limit': 9999});

    return PagingListResponse<CuisineModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<DishTypeModel>> getDishTypes() async {
    final response = await _networkUtility
        .request('v1/dish-types', Method.GET, queryParameters: {'limit': 9999});

    return PagingListResponse<DishTypeModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<IngredientModel>> getIngredients() async {
    final response = await _networkUtility.request('v1/ingredients', Method.GET,
        queryParameters: {'limit': 9999});

    return PagingListResponse<IngredientModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<MenuTypeModel>> getMenuTypes() async {
    final response = await _networkUtility
        .request('v1/menu-types', Method.GET, queryParameters: {'limit': 9999});

    return PagingListResponse<MenuTypeModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<ProductTypeModel>> getProductTypes() async {
    final response = await _networkUtility.request(
        'v1/product-types', Method.GET,
        queryParameters: {'limit': 9999});

    return PagingListResponse<ProductTypeModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<SpecialGoalModel>> getSpecialGoals() async {
    final response = await _networkUtility.request(
        'v1/special-goals', Method.GET,
        queryParameters: {'limit': 9999});

    return PagingListResponse<SpecialGoalModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<UnitModel>> getUnits() async {
    final response = await _networkUtility
        .request('v1/units', Method.GET, queryParameters: {'limit': 9999});

    return PagingListResponse<UnitModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<CookMethodModel>> getCookMethods() async {
    final response = await _networkUtility
        .request('v1/cook-methods', Method.GET, queryParameters: {'limit': 9999});

    return PagingListResponse<CookMethodModel>.fromJson(response);
  }
}
