import 'package:dartz/dartz.dart';
import '../../core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';

class ProductRepository extends IProductRepository {
  final INetworkInfo networkInfo;
  final IProductRemoteService remoteService;

  ProductRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<ProductModel>>> createProduct(
      {required Map<String, dynamic> data}) async {
    try {
      final result = await remoteService.createProduct(data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<SingleType>>> delete(
      {required String productId}) async {
    try {
      final result = await remoteService.delete(productId: productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<ProductModel>>> getById(
      {required String productId}) async {
    try {
      final result =
          await remoteService.getById(productId: productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, PagingListResponse<ProductModel>>> getProducts(
      {required Map<String, dynamic> query}) async {
    try {
      final result =
          await remoteService.getProducts(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, SingleResponse<ProductModel>>> update(
      {required String productId, required Map<String, dynamic> data}) async {
    try {
      final result =
          await remoteService.update(productId: productId, data: data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
