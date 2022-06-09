import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import '../../../extensions/extensions.dart';
import '../../../utils/app_config.dart';
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
    getRecipes(null);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<PagingListResponse> asyncTask(String? text, PaginationConfig config) {
    return bloc.getRecipes(query: text, page: config.page);
  }

  getRecipes(String? text) {
    bloc.paginationHelper = PaginationHelper(asyncTask: (config) {
      return asyncTask(text, config).then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return (value.items as List<RecipeModel>);
      }).catchError((e) => throw e);
    }, onRefresh: () {
      setState(() {});
      bloc.paginationHelper!.run();
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
            heroTag: "Add recipe",
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.addRecipe,
              ).then((value) {
                bloc.updateItem(value as RecipeModel?);
              });
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
      appBar: AppBar(
        title: SearchTextField(
          controller: _searchController,
          onSubmitted: (value) {
            getRecipes(value);
            setState(() {});
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
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: PaginationGridView(
            emptyBuilder: (_) => Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Assets.images.png.search.image(height: 150, width: 150),
                  "Nothing".s16w400(),
                ],
              ),
            ),
            itemBuilder: (BuildContext context, int index) {
              final item = bloc.paginationHelper!.items[index];
              return Material(
                color: Colors.white,
                child: FocusedMenuHolder(
                  menuWidth: (MediaQuery.of(context).size.width - 10 - 12) / 3,
                  blurSize: 0.0,
                  menuItemExtent: 45,
                  menuBoxDecoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
                            Routes.addRecipe,
                            arguments: item,
                          ).then(
                            (value) {
                              bloc.updateItem(value as RecipeModel);
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
                      Routes.recipeDetail,
                      arguments: item,
                    ).then((value) {
                      bloc.updateItem(value as RecipeModel?);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: PreviewRecipe(item: item),
                        ),
                        SizedBox(height: 5),
                        (item.name ?? 'Recipe').s14w500(
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
                                  (item.totalTime!.round().toString() + " Phút")
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
      );
    }
    return errorWidget;
  }
}
