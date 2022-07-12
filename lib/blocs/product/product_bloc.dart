import 'dart:developer';

import 'package:lovecook/extensions/extensions.dart';

import '../../data/enum.dart';
import '../../utils/utils.dart';
import 'product_state.dart';
import '../../core/base/base.dart';
import '../../data/data.dart';

import '../../core/base/base_response.dart';
import '../../widgets/widgets.dart';

class ProductBloc extends BaseBloc<ProductState> {
  final ISearchRepository _searchRepository;
  final ILookupRepository _lookupRepository;
  final IProductRepository _productRepository;
  PaginationHelper<ProductModel>? paginationHelper;

  ProductBloc(
      this._searchRepository, this._lookupRepository, this._productRepository);
  init() async {
    final responseEither = await _lookupRepository.getLookup();
    responseEither.fold((failure) {}, (data) {
      emit((state ?? ProductState()).copyWith(lookup: data.item));
    });
  }

  setUser(User user) {
    emit((state ?? ProductState()).copyWith(user: user));
  }

  Future<PagingListResponse> getProducts({required int page}) async {
    Map<String, dynamic> queryParams = {
      'page': page,
      'type': SearchType.product.shortString,
    };
    if (state?.user != null)
      queryParams.putIfAbsent('creatorId', () => state!.user!.id);
    if (state?.query != null && state!.query!.isNotEmpty)
      queryParams.putIfAbsent('q', () => state!.query);
    if (state?.productType != null)
      queryParams.putIfAbsent('productTypeId', () => state!.productType!.id);
    if (state?.currencyUnit != null)
      queryParams.putIfAbsent('currencyUnit', () => state!.currencyUnit);
    final responseEither = await _searchRepository.search(query: queryParams);
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item!.products!;
    });
  }

  void updateList(ProductModel? product) async {
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

  void deleteItem(ProductModel product) {
    final items = paginationHelper?.items ?? [];
    final index = items.indexWhere((element) => element.id == product.id);
    log(product.toString());
    log(index.toString());
    if (index != -1) {
      items.removeAt(index);
      paginationHelper!.updateList(items);
      _productRepository.delete(productId: product.id!);
    }
  }

  void updateFilter({
    Nullable<ProductTypeModel?>? productType,
    Nullable<String?>? currencyUnit,
    Nullable<String?>? query,
  }) {
    emit((state ?? ProductState()).copyWith(
        currencyUnit: currencyUnit, productType: productType, query: query));
  }

  @override
  void dispose() {
    super.dispose();
    paginationHelper = null;
  }
}
