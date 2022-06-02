import '../../../core/base/base_response.dart';
import '../../data.dart';

abstract class IProductRemoteService {
  Future<SingleResponse<ProductModel>> createProduct(
      {required Map<String, dynamic> data});
  Future<SingleResponse<ProductModel>> getById({required String productId});
  Future<SingleResponse<ProductModel>> update(
      {required String productId, required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> delete({required String productId});
  Future<PagingListResponse<ProductModel>> getProducts(
      {required Map<String, dynamic> query});
}
