import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

import '../../../core/core.dart';

abstract class IPostRepository {
  Future<Either<Failure, SingleResponse<PostModel>>> createPost(
      {required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> react(
      {required String postId, required String type});
  Future<Either<Failure, SingleResponse<SingleType>>> delReact(
      {required String postId});
  Future<Either<Failure, SingleResponse<PostModel>>> getById(
      {required String postId});
  Future<Either<Failure, SingleResponse<PostModel>>> update(
      {required String postId, required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> delete(
      {required String postId});
  Future<Either<Failure, PagingListResponse<PostModel>>> getPosts(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<ReactionModel>>> getReactions(
      {required String postId, required Map<String, dynamic> query});
}
