import 'package:get_it/get_it.dart';
import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class ProductRemoteService implements IProductRemoteService {
  late final INetworkUtility _networkUtility;

  ProductRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<ProductModel>> createProduct(
      {required Map<String, dynamic> data}) async {
    final response =
        await _networkUtility.request('v1/products', Method.POST, data: data);

    return SingleResponse<ProductModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<ProductModel>> update(
      {required String productId, required Map<String, dynamic> data}) async {
    final response = await _networkUtility
        .request('v1/products/$productId', Method.PUT, data: data);

    return SingleResponse<ProductModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> delete({required String productId}) async {
    final response =
        await _networkUtility.request('v1/products/$productId/', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<ProductModel>> getById(
      {required String productId}) async {
    final response =
        await _networkUtility.request('v1/products/$productId/', Method.GET);

    return SingleResponse<ProductModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<ProductModel>> getProducts(
      {required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request('v1/products/', Method.GET,
        queryParameters: query);

    return PagingListResponse<ProductModel>.fromJson(response);
  }
}
