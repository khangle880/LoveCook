import 'package:dartz/dartz.dart';
import '../../../core/base/base_response.dart';
import '../../data.dart';

import '../../../core/core.dart';

abstract class IRecipeRepository {
  Future<Either<Failure, SingleResponse<RecipeModel>>> createRecipe(
      {required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> like(
      {required String recipeId});
  Future<Either<Failure, SingleResponse<SingleType>>> dislike(
      {required String recipeId});
  Future<Either<Failure, SingleResponse<SingleType>>> markCooked(
      {required String recipeId});
  Future<Either<Failure, SingleResponse<SingleType>>> unmarkCooked(
      {required String recipeId});
  Future<Either<Failure, SingleResponse<SingleType>>> vote(
      {required String recipeId, required double point});
  Future<Either<Failure, SingleResponse<SingleType>>> unvote(
      {required String recipeId});
  Future<Either<Failure, SingleResponse<RecipeModel>>> getById(
      {required String recipeId});
  Future<Either<Failure, SingleResponse<RecipeModel>>> update(
      {required String recipeId, required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> delete(
      {required String recipeId});
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getRecipes(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<User>>> getLikedUsers(
      {required String recipeId, required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<User>>> getCookedUsers(
      {required String recipeId, required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<RatingModel>>> getRatings(
      {required String recipeId, required Map<String, dynamic> query});
}
