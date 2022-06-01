import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

abstract class IRecipeRemoteService {
  Future<SingleResponse<RecipeModel>> createRecipe(
      {required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> like({required String recipeId});
  Future<SingleResponse<SingleType>> dislike({required String recipeId});
  Future<SingleResponse<SingleType>> markCooked({required String recipeId});
  Future<SingleResponse<SingleType>> unmarkCooked({required String recipeId});
  Future<SingleResponse<SingleType>> vote(
      {required String recipeId, required double point});
  Future<SingleResponse<SingleType>> unvote({required String recipeId});
  Future<SingleResponse<RecipeModel>> getById({required String recipeId});
  Future<SingleResponse<RecipeModel>> update(
      {required String recipeId, required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> delete({required String recipeId});
  Future<PagingListResponse<RecipeModel>> getRecipes(
      {required Map<String, dynamic> query});
  Future<PagingListResponse<User>> getLikedUsers(
      {required String recipeId, required Map<String, dynamic> query});
  Future<PagingListResponse<User>> getCookedUsers(
      {required String recipeId, required Map<String, dynamic> query});
  Future<PagingListResponse<RatingModel>> getRatings(
      {required String recipeId, required Map<String, dynamic> query});
}
