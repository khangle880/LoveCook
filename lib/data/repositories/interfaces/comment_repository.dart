import 'package:dartz/dartz.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class ICommentRepository {
  Future<Either<Failure, SingleResponse<CommentModel>>> createComment(
      {required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> react(
      {required String commentId, required String type});
  Future<Either<Failure, SingleResponse<SingleType>>> delReact(
      {required String commentId});
  Future<Either<Failure, SingleResponse<CommentModel>>> getById(
      {required String commentId});
  Future<Either<Failure, SingleResponse<CommentModel>>> update(
      {required String commentId, required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> delete(
      {required String commentId});
  Future<Either<Failure, PagingListResponse<CommentModel>>> getComments(
      {required Map<String, dynamic> query});
  Future<Either<Failure, PagingListResponse<ReactionModel>>> getReactions(
      {required String commentId, required Map<String, dynamic> query});
}
