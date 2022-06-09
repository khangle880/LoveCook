import 'package:lovecook/extensions/extensions.dart';

import '../../data/enum.dart';
import 'product_state.dart';
import '../../core/base/base.dart';
import '../../data/data.dart';

import '../../core/base/base_response.dart';
import '../../widgets/widgets.dart';

class ProductBloc extends BaseBloc<ProductState> {
  final IProductRepository _productRepository;
  final ISearchRepository _searchRepository;
  PaginationHelper<ProductModel>? paginationHelper;

  ProductBloc(this._productRepository, this._searchRepository);

  Future<PagingListResponse> getProducts(
      {required int page, String? query}) async {
    if (query != null && query.isNotEmpty) {
      final responseEither = await _searchRepository.search(
          query: query, searchType: SearchType.product, page: page);
      return responseEither.fold((failure) {
        return Future.error(failure);
      }, (data) {
        return data.item!.products!;
      });
    }
    final responseEither =
        await _productRepository.getProducts(query: {'page': page});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  void updateItem(ProductModel? product) async {
    if (product == null) return;
    final items = paginationHelper?.items ?? [];
    final index = items.indexWhere((element) => element.id == product.id);
    var newList;
    if (index == -1) {
      newList = items..insert(0, product);
    } else {
      newList =
          items.replaceItem(product, (element) => element.id == product.id);
    }

    paginationHelper!.updateList(newList);
  }

  @override
  void dispose() {
    super.dispose();
    paginationHelper = null;
  }
}
