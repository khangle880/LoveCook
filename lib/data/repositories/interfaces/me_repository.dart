import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

import '../../../core/core.dart';

abstract class IMeRepository {
  Future<Either<Failure, SingleResponse<User>>> getInfo();
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getLikedRecipe(
      {required Map<String, dynamic> query});
  Future<Either<Failure, SingleResponse<User>>> update({required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> changePassword(
      {required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> deleteAccount();
}
