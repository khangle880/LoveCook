import 'product_state.dart';
import '../../core/base/base.dart';
import '../../data/data.dart';

import '../../core/base/base_response.dart';
import '../../widgets/widgets.dart';

class ProductBloc extends BaseBloc<ProductState> {
  final IProductRepository _productRepository;
  PaginationHelper<ProductModel>? paginationHelper;

  ProductBloc(this._productRepository);

  Future<PagingListResponse> getProducts({required int page}) async {
    final responseEither =
        await _productRepository.getProducts(query: {'page': page});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  @override
  void dispose() {
    super.dispose();
    paginationHelper = null;
  }
}
