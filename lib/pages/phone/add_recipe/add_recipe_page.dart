import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart';
import '../../../core/base/base.dart';
import '../../../data/data.dart';
import '../../../data/enum.dart';
import '../../../extensions/extensions.dart';
import '../../../gen/assets.gen.dart';
import '../../../resources/resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_dialog/app_dialog.dart';
import '../../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class AddRecipePage extends StatefulWidget {
  final AddRecipeBloc bloc;
  const AddRecipePage(this.bloc);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends BaseState<AddRecipePage, AddRecipeBloc> {
  final _formKey = GlobalKey<FormState>();
  bool _isUpdate = false;

  @override
  AddRecipeBloc get bloc => widget.bloc;

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is RecipeModel?) {
      if (payload == null) {
        bloc.init();
      } else {
        _isUpdate = true;
        bloc.loadRecipe(payload);
      }
    }
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: "${_isUpdate ? "Update" : "Create"} recipe".s20w600(),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<AddRecipeState>(
          stream: bloc.stateStream,
          builder: (context, snp) {
            if (!snp.hasData || snp.data?.lookup == null)
              return Center(
                child: CircularProgressIndicator(),
              );
            final lookup = snp.data!.lookup!;
            final state = snp.data!;
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Recipe detail".s24w700(),
                        SizedBox(height: 20),
                        //? Name
                        "Recipe name".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        InputTextWidget(
                          initValue: state.name,
                          hintText: 'Cánh gà chiên giòn',
                          onChanged: (value) {
                            bloc.updateField(name: value);
                          },
                        ),
                        SizedBox(height: 20),
                        //? Description
                        "Description".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        InputTextWidget(
                          initValue: state.description,
                          hintText:
                              'Cánh gà chiên giòn là món ăn ngon không chỉ người lớn mà trẻ em cũng rất thích...',
                          maxLine: 4,
                          onChanged: (value) {
                            bloc.updateField(description: value);
                          },
                        ),
                        SizedBox(height: 20),
                        "Level".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: PickLookup<Level>(
                            value: state.level,
                            hintText: 'Easy',
                            items: Level.values,
                            getText: (item) => item.shortString,
                            onChanged: (value) {
                              bloc.updateField(level: value);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        "Cooking Method"
                            .s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: PickLookup<CookMethodModel>(
                            value: state.cookMethod,
                            hintText: 'Chiên - xào',
                            items: lookup.cookMethods!,
                            getText: (item) => item.names!.join(' - '),
                            onChanged: (value) {
                              bloc.updateField(cookMethod: value);
                            },
                          ),
                        ),
                        SizedBox(height: 25),
                        //? Servings, total time, level
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFDAEAF1),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  )),
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Serving"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: InputTextWidget(
                                      initValue: state.servings == null
                                          ? null
                                          : state.servings.toString(),
                                      hintText: '4',
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        bloc.updateField(
                                          servings: int.tryParse(value),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 30),
                                  "--".s20w600(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Times"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: InputTextWidget(
                                      initValue: state.totalTime == null
                                          ? null
                                          : state.totalTime?.round().toString(),
                                      hintText: 'Phút',
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        bloc.updateField(
                                          totalTime: double.tryParse(value),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //? menuTypes, specialGoals
                        SizedBox(height: 25),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFDAEAF1),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  )),
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Menu Type"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: PickLookup<MenuTypeModel>(
                                      value: state.menuTypes?.first,
                                      hintText: 'Món chính',
                                      items: lookup.menuTypes!,
                                      getText: (item) =>
                                          item.names!.join(' - '),
                                      onChanged: (value) {
                                        bloc.updateField(
                                            menuTypes:
                                                value == null ? null : [value]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 30),
                                  "--".s20w600(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Special goals"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: PickLookup<SpecialGoalModel>(
                                      value: state.specialGoals?.first,
                                      hintText: 'Tăng cân',
                                      items: lookup.goals!,
                                      getText: (item) =>
                                          item.names!.join(' - '),
                                      onChanged: (value) {
                                        bloc.updateField(
                                            specialGoals:
                                                value == null ? null : [value]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //? cuisine, dishType, cookMethod
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFDAEAF1),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  )),
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Cuisine"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: PickLookup<CuisineModel>(
                                      value: state.cuisine,
                                      hintText: 'Món Việt',
                                      items: lookup.cuisines!,
                                      getText: (item) =>
                                          item.names!.join(' - '),
                                      onChanged: (value) {
                                        bloc.updateField(cuisine: value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 30),
                                  "--".s20w600(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Disk type"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: PickLookup<DishTypeModel>(
                                      value: state.dishType,
                                      hintText: 'Lẩu',
                                      items: lookup.dishTypes!,
                                      getText: (item) =>
                                          item.names!.join(' - '),
                                      onChanged: (value) {
                                        bloc.updateField(dishType: value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //? Ingredients
                        SizedBox(height: 20),
                        "Ingredients".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        IngredientSection(
                          ingredients: state.ingredients ?? [],
                          lookup: lookup,
                          bloc: bloc,
                        ),
                        SizedBox(height: 10),
                        //? Cook steps
                        "Cook steps".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        CookStepSection(
                          bloc: bloc,
                          lookup: lookup,
                          steps: state.steps ?? [],
                        ),
                        SizedBox(height: 10),
                        const SizedBox(height: 10),
                        buildListImage(state.photoUrls ?? []),
                        const SizedBox(height: 10),
                        buildVideo(state.videoUrl),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlineButton(
                              onPressed: () async {
                                final photoUrls = await multiImagePick(context);
                                if (photoUrls.isNotEmpty) {
                                  bloc.updateField(photoUrls: photoUrls);
                                }
                              },
                              color: Color(0xFFDAEAF1),
                              height: 100,
                              width: 100,
                              contentBuilder: (color) => Assets
                                  .images.svg.icPickPhoto
                                  .svg(color: Color(0xFF73777B), height: 40),
                            ),
                            SizedBox(width: 10),
                            OutlineButton(
                              onPressed: () async {
                                final videoUrl = await singleVideoPick(context);
                                var thumnail;
                                if (videoUrl != null) {
                                  Future.delayed(
                                    Duration(milliseconds: 1000),
                                    () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AppInformationDialog(
                                        content: "Choose a thumnail for video",
                                      ),
                                    ),
                                  );
                                  thumnail = await singleImagePick(context);
                                }
                                if (videoUrl != null && thumnail != null) {
                                  bloc.updateField(
                                    videoUrl: videoUrl,
                                    videoThumbnail: thumnail,
                                  );
                                }
                              },
                              color: Color(0xFFDAEAF1),
                              height: 100,
                              width: 100,
                              contentBuilder: (color) => Assets.images.svg.video
                                  .svg(color: Color(0xFF73777B), height: 40),
                            ),
                          ],
                        ),
                        //? Submit
                        const SizedBox(height: 20),
                        MaterialInkwellButton(
                            title: 'Submit',
                            hasBorder: false,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                var value = await bloc.saveRecipe();
                                await Future.delayed(
                                    Duration(milliseconds: 1000));
                                Navigator.pop(context, value);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => AppInformationDialog(
                                      content:
                                          "You need fullfill form before save!"),
                                );
                              }
                            }),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildListImage(List<String> filePaths) {
    if (filePaths.isEmpty) return SizedBox.shrink();
    return CarouselSlider(
      options: CarouselOptions(height: 300.0),
      items: filePaths.map((imageData) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.transparent),
              child: imageData.contains('/storage')
                  ? Image.file(File(imageData), fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: AppConfig.instance.formatLink(imageData),
                      fit: BoxFit.cover,
                    ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildVideo(String? videoPath) {
    if (videoPath == null) return SizedBox.shrink();
    return Builder(
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: VideoWidget(
            file: videoPath.contains('/storage') ? videoPath : null,
            path: !videoPath.contains('/storage')
                ? AppConfig.instance.formatLink(videoPath)
                : null,
          ),
        );
      },
    );
  }
}
