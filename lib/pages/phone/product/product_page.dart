import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:lovecook/extensions/extensions.dart';

import '../../../blocs/blocs.dart';
import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../gen/assets.gen.dart';
import '../../../resources/resources.dart';
import '../../../router/router.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ProductPage extends StatefulWidget {
  final ProductBloc bloc;

  const ProductPage(this.bloc);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends BaseState<ProductPage, ProductBloc> {
  late TextEditingController _searchController;
  bool _showFab = true;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is User) {
      bloc.setUser(payload);
    }
    bloc.init();
    getProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SearchTextField(
          controller: _searchController,
          onSubmitted: (value) {
            bloc.updateFilter(query: Nullable(value));
            getProducts();
          },
        ),
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        offset: _showFab ? Offset.zero : const Offset(0, 1),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
            heroTag: "Add product",
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.addProduct,
              ).then((value) {
                bloc.updateItem(value as ProductModel?);
              });
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final ScrollDirection direction = notification.direction;
          setState(() {
            if (direction == ScrollDirection.reverse) {
              _showFab = false;
            } else if (direction == ScrollDirection.forward) {
              _showFab = true;
            }
          });
          return true;
        },
        child: StreamBuilder<ProductState>(
          stream: bloc.stateStream,
          builder: ((context, snapshot) {
            if (!snapshot.hasData || snapshot.data?.lookup == null)
              return Center(
                child: CircularProgressIndicator(),
              );
            final lookup = snapshot.data!.lookup!;
            final state = snapshot.data;
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          child: PickLookup<ProductTypeModel?>(
                            value: state?.productType,
                            hintText: 'Product type',
                            items: List<ProductTypeModel?>.from(
                                [null, ...lookup.productTypes!]),
                            getText: (item) => item == null
                                ? "Product type"
                                : item.names!.join(' - '),
                            validator: (_) {},
                            onChanged: (value) {
                              bloc.updateFilter(productType: Nullable(value));
                              getProducts();
                            },
                          ),
                        ),
                        Container(
                          width: 140,
                          child: PickLookup<String?>(
                            value: state?.currencyUnit,
                            hintText: 'Unit',
                            items: List<String?>.from([
                              null,
                              "₫ (VND)",
                              "\$ (USD)",
                              "€ (EUR)",
                              "¥ (JPY)",
                              "¥ (CNY)",
                              "\$ (SGD)",
                              "₩ (KRW)",
                            ]),
                            getText: (item) => item == null ? "Unit" : item,
                            validator: (_) {},
                            onChanged: (value) {
                              bloc.updateFilter(currencyUnit: Nullable(value));
                              getProducts();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: PaginationGridView(
                      emptyBuilder: (_) => Center(
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Assets.images.png.search
                                .image(height: 150, width: 150),
                            "Nothing".s16w400(),
                          ],
                        ),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = bloc.paginationHelper!.items[index];
                        return Material(
                          color: Colors.white,
                          child: FocusedMenuHolder(
                            menuWidth:
                                (MediaQuery.of(context).size.width - 10 - 12) /
                                    3,
                            blurSize: 0.0,
                            menuItemExtent: 45,
                            menuBoxDecoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            duration: Duration(milliseconds: 100),
                            animateMenuItems: true,
                            blurBackgroundColor: AppColors.blackLight,
                            menuOffset: 10.0,
                            bottomOffsetHeight: 80.0,
                            menuItems: <FocusedMenuItem>[
                              FocusedMenuItem(
                                  title: Text("Update"),
                                  trailingIcon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.addProduct,
                                      arguments: item,
                                    ).then(
                                      (value) {
                                        bloc.updateItem(value as ProductModel);
                                      },
                                    );
                                  }),
                              FocusedMenuItem(
                                  title: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  trailingIcon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {}),
                            ],
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.productDetail,
                                arguments: item,
                              ).then((value) {
                                bloc.updateItem(value as ProductModel?);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.all(5),
                              child: ProductItem(
                                product: item,
                              ),
                            ),
                          ),
                        );
                      },
                      paginationController: bloc.paginationHelper!,
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 10,
                      childAspectRatio: 80 / 140,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  ProductBloc get bloc => widget.bloc;
}

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: PreviewProduct(item: product),
        ),
        SizedBox(height: 5),
        (product.name ?? 'Product').s14w500(
          config: TextStyleExtConfig(overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 3),
        (product.creator!.name ?? 'User').s12w600(
          color: AppColors.grayNormal.withOpacity(0.6),
        ),
        SizedBox(height: 2),
        product.productType!.names![0].s12w600(
          style: TextStyle(fontWeight: FontWeight.w500),
          config: TextStyleExtConfig(overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class PreviewProduct extends StatefulWidget {
  const PreviewProduct({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  State<PreviewProduct> createState() => _PreviewProductState();
}

class _PreviewProductState extends State<PreviewProduct> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? photoUrl;
    if (widget.item.videoThumbnail != null) {
      photoUrl = widget.item.videoThumbnail!;
    } else if (widget.item.photoUrls != null &&
        widget.item.photoUrls!.isNotEmpty) {
      photoUrl = widget.item.photoUrls![0];
    }
    Widget errorWidget = Container(
      color: AppColors.grayLight,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Assets.images.png.defaultRecipe.image(),
      ),
    );

    if (photoUrl != null) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 130,
            width: 130,
            child: CachedNetworkImage(
              imageUrl: AppConfig.instance.formatLink(photoUrl),
              placeholder: (context, url) => Center(
                child: Container(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => errorWidget,
              fit: BoxFit.cover,
            ),
          ),
          // play button
          if (widget.item.videoUrl != null)
            Container(
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.whiteLight,
                child:
                    Icon(Icons.play_arrow, color: Colors.grey[800], size: 32),
              ),
            ),
        ],
      );
    }
    return errorWidget;
  }
}
