import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';

class LookupRepository extends ILookupRepository {
  final INetworkInfo networkInfo;
  final ILookupRemoteService remoteService;

  LookupRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, PagingListResponse<CookMethodModel>>>
      getCookMethods() async {
    try {
      final result = await remoteService.getCookMethods();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<CuisineModel>>>
      getCuisines() async {
    try {
      final result = await remoteService.getCuisines();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<DishTypeModel>>>
      getDishTypes() async {
    try {
      final result = await remoteService.getDishTypes();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<IngredientModel>>>
      getIngredients() async {
    try {
      final result = await remoteService.getIngredients();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<MenuTypeModel>>>
      getMenuTypes() async {
    try {
      final result = await remoteService.getMenuTypes();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<ProductTypeModel>>>
      getProductTypes() async {
    try {
      final result = await remoteService.getProductTypes();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<SpecialGoalModel>>>
      getSpecialGoals() async {
    try {
      final result = await remoteService.getSpecialGoals();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<UnitModel>>> getUnits() async {
    try {
      final result = await remoteService.getUnits();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
