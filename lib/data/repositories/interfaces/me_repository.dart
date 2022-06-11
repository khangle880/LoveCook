import 'package:dartz/dartz.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class IMeRepository {
  Future<Either<Failure, SingleResponse<User>>> getInfo();
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getLikedRecipe(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getRecipes(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<PostModel>>> getPosts(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<ProductModel>>> getProducts(
      {required Map<String, dynamic> query});
  Future<Either<Failure, SingleResponse<User>>> update(
      {required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> changePassword(
      {required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> deleteAccount();
}
