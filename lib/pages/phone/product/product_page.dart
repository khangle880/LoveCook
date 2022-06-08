import 'dart:async';

import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart';
import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../widgets/widgets.dart';

class ProductPage extends StatefulWidget {
  final ProductBloc bloc;

  const ProductPage(this.bloc);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends BaseState<ProductPage, ProductBloc> {
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getProducts() {
    bloc.paginationHelper = PaginationHelper(asyncTask: (config) {
      return asyncTask(config).then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return (value.items as List<ProductModel>);
      }).catchError((e) => throw e);
    }, onRefresh: () {
      setState(() {});
      bloc.paginationHelper!.run();
    });

    return bloc.paginationHelper?.run();
  }

  Future<PagingListResponse> asyncTask(PaginationConfig config) {
    return bloc.getProducts(page: config.page);
  }

  @override
  ProductBloc get bloc => widget.bloc;
}
