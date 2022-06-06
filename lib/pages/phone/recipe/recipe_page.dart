import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lovecook/extensions/extensions.dart';
import 'package:lovecook/utils/app_config.dart';
import '../../../blocs/blocs.dart';
import '../../../core/base/base_response.dart';
import '../../../data/data.dart';

import '../../../core/core.dart';
import '../../../gen/assets.gen.dart';
import '../../../resources/resources.dart';
import '../../../router/router.dart';
import '../../../widgets/widgets.dart';

class RecipePage extends StatefulWidget {
  final RecipeBloc bloc;

  const RecipePage(this.bloc);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends BaseState<RecipePage, RecipeBloc> {
  late TextEditingController _searchController;
  bool _showFab = true;

  @override
  void initState() {
    _searchController = TextEditingController();
    getRecipes();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  getRecipes() {
    bloc.paginationHelper = PaginationHelper(asyncTask: (config) {
      return asyncTask(config).then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return (value.items as List<RecipeModel>);
      }).catchError((e) => throw e);
    }, onRefresh: () {
      bloc.bsRecipes.add(null);
      bloc.paginationHelper!.run();
    });
    bloc.paginationHelper!.addListener(() {
      bloc.bsRecipes.add(bloc.paginationHelper!.items);
    });

    return bloc.paginationHelper?.run();
  }

  Future<PagingListResponse> asyncTask(PaginationConfig config) {
    return bloc.getRecipes(page: config.page);
  }

  Future<PagingListResponse> searchAsyncTask(
      String text, PaginationConfig config) {
    return bloc.getSearch(text: text, page: config.page);
  }

  initSearch(String text) {
    bloc.paginationHelper = PaginationHelper(asyncTask: (config) {
      return searchAsyncTask(text, config).then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return (value.items as List<RecipeModel>);
      }).catchError((e) => throw e);
    }, onRefresh: () {
      bloc.bsRecipes.add(null);
      bloc.paginationHelper!.run();
    });
    bloc.paginationHelper!.addListener(() {
      bloc.bsRecipes.add(bloc.paginationHelper!.items);
    });
    return bloc.paginationHelper?.run();
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        offset: _showFab ? Offset.zero : const Offset(0, 1),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.addRecipe,
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
      appBar: AppBar(
        title: SearchTextField(
          controller: _searchController,
          onSubmitted: (value) {
            log(value);
            if (value.isEmpty) {
              getRecipes();
            } else {
              initSearch(value);
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
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
        child: Column(
          children: [
            SizedBox(height: 8),
            StreamBuilder<List<RecipeModel>?>(
              stream: bloc.bsRecipes,
              builder: (context, snp) {
                if (snp.data == null) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snp.data!.isNotEmpty) {
                  return Expanded(
                    child: PaginationGridView(
                      itemBuilder: (BuildContext context, int index) {
                        final item = bloc.paginationHelper!.items[index];
                        return Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.recipeDetail,
                                arguments: item,
                              ).then((value) {
                                bloc.updateItem(value as RecipeModel?);
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: PreviewRecipe(item: item),
                                ),
                                SizedBox(height: 5),
                                (item.name ?? 'Food').s14w500(
                                  config: TextStyleExtConfig(
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(height: 3),
                                (item.creator!.name ?? 'User').s12w600(
                                  color: AppColors.grayNormal.withOpacity(0.6),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                          (item.totalTime!.round().toString() +
                                                  " Phút")
                                              .s12w600(),
                                    ),
                                    FavoriteButton(
                                      initFavorite: item.isLiked ?? false,
                                      onClicked: (value) =>
                                          bloc.handleLikeRecipe(item, value),
                                      size: 18,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      paginationController: bloc.paginationHelper!,
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 80 / 130,
                      padding: EdgeInsets.all(10),
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(height: 50),
                    Assets.images.png.search.image(),
                    "Nothing".s16w400(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  RecipeBloc get bloc => widget.bloc;
}

class PreviewRecipe extends StatefulWidget {
  const PreviewRecipe({
    Key? key,
    required this.item,
  }) : super(key: key);

  final RecipeModel item;

  @override
  State<PreviewRecipe> createState() => _PreviewRecipeState();
}

class _PreviewRecipeState extends State<PreviewRecipe> {
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
      return Container(
        height: 130,
        width: 130,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: AppConfig.instance.formatLink(photoUrl),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => errorWidget,
            ),
            // play button
            if (widget.item.videoThumbnail != null)
              Container(
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.whiteLight,
                  child:
                      Icon(Icons.play_arrow, color: Colors.grey[800], size: 32),
                ),
              ),
          ],
        ),
      );
    }
    return errorWidget;
  }
}
