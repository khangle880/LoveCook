import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';

class UserRepository extends IUserRepository {
  final INetworkInfo networkInfo;
  final IUserRemoteService remoteService;

  UserRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<User>>> follow(
      {required String userId}) async {
    try {
      final result = await remoteService.follow(userId: userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getLikedRecipes(
      {required String userId, required Map<String, dynamic> query}) async {
    try {
      final result =
          await remoteService.getLikedRecipes(userId: userId, query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<User>>> getUser(
      {required String userId}) async {
    try {
      final result = await remoteService.getUser(userId: userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<User>>> getUsers(
      {required Map<String, dynamic> query}) async {
    try {
      final result = await remoteService.getUsers(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<User>>> unfollow(
      {required String userId}) async {
    try {
      final result = await remoteService.unfollow(userId: userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
