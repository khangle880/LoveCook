import 'package:dartz/dartz.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class IUserRepository {
  Future<Either<Failure, SingleResponse<User>>> getUser(
      {required String userId});
  Future<Either<Failure, PagingListResponse<User>>> getUsers(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getLikedRecipes(
      {required String userId, required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getRecipes(
      {required String userId, required Map<String, dynamic> query});
  Future<Either<Failure, SingleResponse<User>>> follow(
      {required String userId});
  Future<Either<Failure, SingleResponse<User>>> unfollow(
      {required String userId});
  Future<Either<Failure, PagingListResponse<User>>> getFollowers(
      {required String userId, required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<User>>> getFollowings(
      {required String userId, required Map<String, dynamic> query});
}
