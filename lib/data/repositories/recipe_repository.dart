import 'package:dartz/dartz.dart';
import '../../core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';

class RecipeRepository extends IRecipeRepository {
  final INetworkInfo networkInfo;
  final IRecipeRemoteService remoteService;

  RecipeRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<RecipeModel>>> createRecipe(
      {required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.createRecipe(data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> delete(
      {required String recipeId}) async {
    try {
      final result = await remoteService.delete(recipeId: recipeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> dislike(
      {required String recipeId}) async {
    try {
      final result = await remoteService.dislike(recipeId: recipeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<RecipeModel>>> getById(
      {required String recipeId}) async {
    try {
      final result = await remoteService.getById(recipeId: recipeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<User>>> getCookedUsers(
      {required String recipeId, required Map<String, dynamic> query}) async {
    try {
      final result =
          await remoteService.getCookedUsers(recipeId: recipeId, query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<User>>> getLikedUsers(
      {required String recipeId, required Map<String, dynamic> query}) async {
    try {
      final result =
          await remoteService.getLikedUsers(recipeId: recipeId, query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<RatingModel>>> getRatings(
      {required String recipeId, required Map<String, dynamic> query}) async {
    try {
      final result =
          await remoteService.getRatings(recipeId: recipeId, query: query);
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
  Future<Either<Failure, SingleResponse<SingleType>>> like(
      {required String recipeId}) async {
    try {
      final result = await remoteService.like(recipeId: recipeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> markCooked(
      {required String recipeId}) async {
    try {
      final result = await remoteService.markCooked(recipeId: recipeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> unmarkCooked(
      {required String recipeId}) async {
    try {
      final result = await remoteService.unmarkCooked(recipeId: recipeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> unvote(
      {required String recipeId}) async {
    try {
      final result = await remoteService.unvote(recipeId: recipeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<RecipeModel>>> update(
      {required String recipeId, required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.update(recipeId: recipeId, data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> vote(
      {required String recipeId, required double point}) async {
    try {
      final result = await remoteService.vote(recipeId: recipeId, point: point);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
