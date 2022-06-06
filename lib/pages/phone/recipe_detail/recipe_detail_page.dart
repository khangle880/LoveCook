import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lovecook/extensions/extensions.dart';
import 'package:lovecook/utils/app_config.dart';
import 'package:lovecook/widgets/pick_media/pick_media.dart';
import 'package:lovecook/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import '../../../blocs/blocs.dart';
import '../../../core/base/base_response.dart';
import '../../../data/data.dart';

import '../../../core/core.dart';
import '../../../gen/assets.gen.dart';
import '../../../resources/resources.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeDetailBloc bloc;

  const RecipeDetailPage(this.bloc);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState
    extends BaseState<RecipeDetailPage, RecipeDetailBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is RecipeModel) {
      bloc.updateRecipe(payload);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, bloc.state?.recipe);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: 'Công thức'.s18w600(),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<RecipeModel?>(
          stream: bloc.recipeStream,
          builder: (context, snp) {
            if (snp.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final item = snp.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      MediaView(item: item),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            item.name!.s16w500(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                AbsorbPointer(
                                  absorbing: true,
                                  child: FavoriteButton(size: 20),
                                ),
                                SizedBox(width: 5),
                                item.totalLikes.toString().s12w400(),
                                SizedBox(width: 20),
                                Assets.images.svg.eye.svg(height: 20),
                                SizedBox(width: 5),
                                item.totalView!.toInt().toString().s12w400()
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                ProfileAvatar(
                                    imageUrl: item.creator?.avatarUrl),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.creator?.name ?? 'User',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: bloc.recipesOfCreator,
                                        builder: (context, snapshot) {
                                          return ((snapshot.data ?? 0)
                                                      .toString() +
                                                  " Công thức")
                                              .s12w400();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            item.description!.s12w400(),
                            SizedBox(height: 10),
                            IngredientsView(recipe: item),
                            CookSteps(steps: item.steps ?? [])
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FavoriteButton(
                              initFavorite: item.isLiked ?? false,
                              onClicked: (value) =>
                                  bloc.handleLikeRecipe(item, value),
                              size: 23,
                            ),
                          ),
                          "Lưu".s12w400(),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Assets.images.svg.share
                                .svg(height: 20, width: 20),
                          ),
                          "Chia sẻ".s12w400(),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  RecipeDetailBloc get bloc => widget.bloc;
}

class MediaView extends StatelessWidget {
  const MediaView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final RecipeModel item;

  @override
  Widget build(BuildContext context) {
    if (item.videoUrl != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: VideoWidget(path: AppConfig.instance.formatLink(item.videoUrl!)),
      );
    }
    return PhotosSlider(
      photoUrls: item.photoUrls ?? [],
      options: CarouselOptions(
        autoPlay: true,
      ),
    );
  }
}

class IngredientsView extends StatelessWidget {
  final RecipeModel recipe;
  const IngredientsView({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        "Nguyên liệu".s13w500(),
        (recipe.servings!.toString() + ' Khẩu phần')
            .s10w400(color: AppColors.grayDarken),
        Divider(height: 20),
        ...(recipe.ingredients ?? []).map((item) => Column(
              children: [
                Row(
                  children: [
                    item.name!
                        .s12w400(style: TextStyle(fontWeight: FontWeight.w500)),
                    Spacer(),
                    (item.quantity!.round().toString() + " " + item.unit!.name!)
                        .s12w400(style: TextStyle(fontWeight: FontWeight.w500))
                  ],
                ),
                Divider(height: 20),
              ],
            )),
      ],
    );
  }
}

class CookSteps extends StatelessWidget {
  final List<CookStepModel> steps;
  const CookSteps({
    Key? key,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container(
      color: AppColors.grayLight,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Assets.images.png.defaultRecipe.image(),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: "Hướng dẫn thực hiện".s13w500(),
        ),
        ...steps.map(
          (e) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ((steps.indexOf(e) + 1).toString() + ".").s12w400(),
              SizedBox(width: 3),
              Expanded(
                child: Column(
                  children: [
                    e.content!.s12w400(
                      config: TextStyleExtConfig(maxLines: 10),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...(e.photoUrls ?? []).map((e) => CachedNetworkImage(
                                imageUrl: AppConfig.instance.formatLink(e),
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    errorWidget,
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
