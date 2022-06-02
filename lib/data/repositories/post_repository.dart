import 'package:dartz/dartz.dart';
import '../../core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';

class PostRepository extends IPostRepository {
  final INetworkInfo networkInfo;
  final IPostRemoteService remoteService;

  PostRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<PostModel>>> createPost(
      {required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.createPost(data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> delReact(
      {required String postId}) async {
    try {
      final result = await remoteService.delReact(postId: postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> delete(
      {required String postId}) async {
    try {
      final result = await remoteService.delReact(postId: postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<PostModel>>> getById(
      {required String postId}) async {
    try {
      final result = await remoteService.getById(postId: postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<PostModel>>> getPosts(
      {required Map<String, dynamic> query}) async {
    try {
      final result = await remoteService.getPosts(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<ReactionModel>>> getReactions(
      {required String postId, required Map<String, dynamic> query}) async {
    try {
      final result =
          await remoteService.getReactions(postId: postId, query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> react(
      {required String postId, required String type}) async {
    try {
      final result = await remoteService.react(postId: postId, type: type);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<PostModel>>> update(
      {required String postId, required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.update(postId: postId, data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
