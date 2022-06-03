import 'package:get_it/get_it.dart';
import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class UserRemoteService implements IUserRemoteService {
  late final INetworkUtility _networkUtility;

  UserRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<User>> getUser({required String userId}) async {
    final response =
        await _networkUtility.request('v1/users/$userId', Method.GET);

    return SingleResponse<User>.fromJson(response);
  }

  @override
  Future<SingleResponse<User>> follow({required String userId}) async {
    final response =
        await _networkUtility.request('v1/users/$userId/follow', Method.POST);

    return SingleResponse<User>.fromJson(response);
  }

  @override
  Future<SingleResponse<User>> unfollow({required String userId}) async {
    final response = await _networkUtility.request(
        'v1/users/$userId/unfollow', Method.DELETE);

    return SingleResponse<User>.fromJson(response);
  }

  @override
  Future<PagingListResponse<User>> getUsers(
      {required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request('v1/users/', Method.GET,
        queryParameters: query);

    return PagingListResponse<User>.fromJson(response);
  }

  @override
  Future<PagingListResponse<RecipeModel>> getLikedRecipes(
      {required String userId, required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request(
        'v1/users/$userId/liked-recipes', Method.GET,
        queryParameters: query);

    return PagingListResponse<RecipeModel>.fromJson(response);
  }
}
