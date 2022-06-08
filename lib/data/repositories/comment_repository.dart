import 'package:dartz/dartz.dart';

import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class CommentRepository extends ICommentRepository {
  final INetworkInfo networkInfo;
  final ICommentRemoteService remoteService;

  CommentRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<CommentModel>>> createComment(
      {required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.createComment(data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> delReact(
      {required String commentId}) async {
    try {
      final result = await remoteService.delReact(commentId: commentId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> delete(
      {required String commentId}) async {
    try {
      final result = await remoteService.delete(commentId: commentId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<CommentModel>>> getById(
      {required String commentId}) async {
    try {
      final result = await remoteService.getById(commentId: commentId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<CommentModel>>> getComments(
      {required Map<String, dynamic> query}) async {
    try {
      final result = await remoteService.getComments(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<ReactionModel>>> getReactions(
      {required String commentId, required Map<String, dynamic> query}) async {
    try {
      final result =
          await remoteService.getReactions(commentId: commentId, query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> react(
      {required String commentId, required String type}) async {
    try {
      final result =
          await remoteService.react(commentId: commentId, type: type);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<CommentModel>>> update(
      {required String commentId, required Map<String, dynamic> data}) async {
    try {
      final result =
          await remoteService.update(commentId: commentId, data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
