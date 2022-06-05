import 'dart:developer';

import 'package:get_it/get_it.dart';
import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class RecipeRemoteService implements IRecipeRemoteService {
  late final INetworkUtility _networkUtility;

  RecipeRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<RecipeModel>> createRecipe(
      {required Map<String, dynamic> data}) async {
    final response =
        await _networkUtility.request('v1/recipes/', Method.POST, data: data);

    return SingleResponse<RecipeModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> like({required String recipeId}) async {
    final response =
        await _networkUtility.request('v1/recipes/$recipeId/like', Method.POST);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> dislike({required String recipeId}) async {
    final response = await _networkUtility.request(
        'v1/recipes/$recipeId/dislike', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> markCooked(
      {required String recipeId}) async {
    final response = await _networkUtility.request(
        'v1/recipes/$recipeId/mark-cook', Method.POST);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> unmarkCooked(
      {required String recipeId}) async {
    final response = await _networkUtility.request(
        'v1/recipes/$recipeId/unmark-cook', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> vote(
      {required String recipeId, required double point}) async {
    final response =
        await _networkUtility.request('v1/recipes/$recipeId/vote', Method.POST);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> unvote({required String recipeId}) async {
    final response = await _networkUtility.request(
        'v1/recipes/$recipeId/unvote', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<RecipeModel>> getById(
      {required String recipeId}) async {
    final response =
        await _networkUtility.request('v1/recipes/$recipeId', Method.GET);

    return SingleResponse<RecipeModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> delete({required String recipeId}) async {
    final response =
        await _networkUtility.request('v1/recipes/$recipeId', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<RecipeModel>> update(
      {required String recipeId, required Map<String, dynamic> data}) async {
    final response = await _networkUtility
        .request('v1/recipes/$recipeId', Method.PUT, data: data);

    return SingleResponse<RecipeModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<RecipeModel>> getRecipes(
      {required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request('v1/recipes/', Method.GET,
        queryParameters: query);

    return PagingListResponse<RecipeModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<User>> getCookedUsers(
      {required String recipeId, required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request(
        'v1/recipes/$recipeId/cooked-users', Method.GET,
        queryParameters: query);

    return PagingListResponse<User>.fromJson(response);
  }

  @override
  Future<PagingListResponse<User>> getLikedUsers(
      {required String recipeId, required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request(
        'v1/recipes/$recipeId/liked-users', Method.GET,
        queryParameters: query);

    return PagingListResponse<User>.fromJson(response);
  }

  @override
  Future<PagingListResponse<RatingModel>> getRatings(
      {required String recipeId, required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request(
        'v1/recipes/$recipeId/rating-users', Method.GET,
        queryParameters: query);

    return PagingListResponse<RatingModel>.fromJson(response);
  }
}
