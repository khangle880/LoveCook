import 'package:dartz/dartz.dart';
import '../../../core/base/base_response.dart';
import '../../data.dart';

import '../../../core/core.dart';

abstract class IProductRepository {
  Future<Either<Failure, SingleResponse<ProductModel>>> createProduct(
      {required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<ProductModel>>> getById({required String productId});
  Future<Either<Failure, SingleResponse<ProductModel>>> update(
      {required String productId, required Map<String, dynamic> data});
  Future<Either<Failure, SingleResponse<SingleType>>> delete({required String productId});
  Future<Either<Failure, PagingListResponse<ProductModel>>> getProducts(
      {required Map<String, dynamic> query});
}
