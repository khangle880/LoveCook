import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

import '../../../core/core.dart';

abstract class IUserRepository {
  Future<Either<Failure, SingleResponse<User>>> getUser({required String userId});
  Future<Either<Failure, PagingListResponse<User>>> getUsers(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getLikedRecipes(
      {required String userId, required Map<String, dynamic> query});
  Future<Either<Failure, SingleResponse<User>>> follow({required String userId});
  Future<Either<Failure, SingleResponse<User>>> unfollow({required String userId});
}
