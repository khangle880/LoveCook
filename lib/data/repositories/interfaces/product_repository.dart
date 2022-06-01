import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

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
