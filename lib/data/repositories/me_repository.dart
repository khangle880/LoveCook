import 'package:dartz/dartz.dart';
import '../../core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';

class MeRepository extends IMeRepository {
  final INetworkInfo networkInfo;
  final IMeRemoteService remoteService;

  MeRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> changePassword(
      {required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.changePassword(data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> deleteAccount() async {
    try {
      final result = await remoteService.deleteAccount();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<User>>> getInfo() async {
    try {
      final result = await remoteService.getInfo();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getLikedRecipe(
      {required Map<String, dynamic> query}) async {
    try {
      final result = await remoteService.getLikedRecipes(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<RecipeModel>>> getRecipes(
      {required Map<String, dynamic> query}) async {
    try {
      final result = await remoteService.getRecipes(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<User>>> update(
      {required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.update(data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
