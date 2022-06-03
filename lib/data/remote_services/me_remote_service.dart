import 'package:get_it/get_it.dart';

import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class MeRemoteService implements IMeRemoteService {
  late final INetworkUtility _networkUtility;

  MeRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<User>> getInfo() async {
    final response = await _networkUtility.request('v1/me/', Method.GET);

    return SingleResponse<User>.fromJson(response);
  }

  @override
  Future<SingleResponse<User>> update(
      {required Map<String, dynamic> data}) async {
    final response =
        await _networkUtility.request('v1/me/', Method.PUT, data: data);

    return SingleResponse<User>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> deleteAccount() async {
    final response = await _networkUtility.request(
      'v1/me/',
      Method.DELETE,
    );

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> changePassword(
      {required Map<String, dynamic> data}) async {
    final response = await _networkUtility
        .request('v1/me/change-password/', Method.PUT, data: data);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<PagingListResponse<RecipeModel>> getLikedRecipe(
      {required Map<String, dynamic> query}) async {
    final response = await _networkUtility
        .request('v1/me/liked-recipes', Method.GET, queryParameters: query);

    return PagingListResponse<RecipeModel>.fromJson(response);
  }
}
