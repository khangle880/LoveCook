import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart';
import '../../../core/base/base.dart';
import '../../../data/data.dart';
import '../../../data/enum.dart';
import '../../../gen/assets.gen.dart';
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

  @override
  AddRecipeBloc get bloc => widget.bloc;

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is RecipeModel?) {
      if (payload == null) {
        bloc.init();
      } else
        bloc.loadRecipe(payload);
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
        appBar: AppBar(),
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
                      children: [
                        SizedBox(height: 5),
                        Text(
                          "Overview",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        //? Name
                        InputTextWidget(
                          initValue: state.name,
                          hintText: 'Recipe name',
                          onChanged: (value) {
                            bloc.updateField(name: value);
                          },
                        ),
                        SizedBox(height: 10),
                        //? Description
                        InputTextWidget(
                          initValue: state.description,
                          hintText: 'Description',
                          maxLine: 4,
                          onChanged: (value) {
                            bloc.updateField(description: value);
                          },
                        ),
                        SizedBox(height: 10),
                        //? Servings, total time, level
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: InputTextWidget(
                                initValue: state.servings == null
                                    ? null
                                    : state.servings.toString(),
                                hintText: 'Servings',
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  bloc.updateField(
                                    servings: int.tryParse(value),
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  child: InputTextWidget(
                                    initValue: state.totalTime == null
                                        ? null
                                        : state.totalTime?.round().toString(),
                                    hintText: 'Time',
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      bloc.updateField(
                                        totalTime: double.tryParse(value),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("Minutes"),
                              ],
                            ),
                            Container(
                              width: 120,
                              child: PickLookup<Level>(
                                value: state.level,
                                hintText: 'Level',
                                items: Level.values,
                                getText: (item) => item.shortString,
                                onChanged: (value) {
                                  bloc.updateField(level: value);
                                },
                              ),
                            ),
                          ],
                        ),
                        //? menuTypes, specialGoals
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 180,
                              child: PickLookup<MenuTypeModel>(
                                value: state.menuTypes?.first,
                                hintText: 'Menu types',
                                items: lookup.menuTypes!,
                                getText: (item) => item.names!.join(' - '),
                                onChanged: (value) {
                                  bloc.updateField(
                                      menuTypes:
                                          value == null ? null : [value]);
                                },
                              ),
                            ),
                            Container(
                              width: 180,
                              child: PickLookup<SpecialGoalModel>(
                                value: state.specialGoals?.first,
                                hintText: 'Special goals',
                                items: lookup.goals!,
                                getText: (item) => item.names!.join(' - '),
                                onChanged: (value) {
                                  bloc.updateField(
                                      specialGoals:
                                          value == null ? null : [value]);
                                },
                              ),
                            ),
                          ],
                        ),
                        //? cuisine, dishType, cookMethod
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child: PickLookup<CuisineModel>(
                                value: state.cuisine,
                                hintText: 'Cuisine',
                                items: lookup.cuisines!,
                                getText: (item) => item.names!.join(' - '),
                                onChanged: (value) {
                                  bloc.updateField(cuisine: value);
                                },
                              ),
                            ),
                            Container(
                              width: 120,
                              child: PickLookup<DishTypeModel>(
                                value: state.dishType,
                                hintText: 'Dish type',
                                items: lookup.dishTypes!,
                                getText: (item) => item.names!.join(' - '),
                                onChanged: (value) {
                                  bloc.updateField(dishType: value);
                                },
                              ),
                            ),
                            Container(
                              width: 120,
                              child: PickLookup<CookMethodModel>(
                                value: state.cookMethod,
                                hintText: 'Cook method',
                                items: lookup.cookMethods!,
                                getText: (item) => item.names!.join(' - '),
                                onChanged: (value) {
                                  bloc.updateField(cookMethod: value);
                                },
                              ),
                            ),
                          ],
                        ),
                        //? Ingredients
                        SizedBox(height: 20),
                        Text(
                          "Ingredients",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        IngredientSection(
                          ingredients: state.ingredients ?? [],
                          lookup: lookup,
                          bloc: bloc,
                        ),
                        SizedBox(height: 10),
                        //? Cook steps
                        Text(
                          "Cook steps",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        CookStepSection(
                          bloc: bloc,
                          lookup: lookup,
                          steps: state.steps ?? [],
                        ),
                        SizedBox(height: 10),
                        const SizedBox(height: 10),
                        buildVideo(state.videoUrl),
                        const SizedBox(height: 10),
                        buildListImage(state.photoUrls ?? []),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButton(
                              icon: Assets.images.svg.icPickPhoto
                                  .svg(color: Color(0xFF73777B)),
                              onTap: () async {
                                final photoUrls = await multiImagePick(context);
                                if (photoUrls.isNotEmpty) {
                                  bloc.updateField(photoUrls: photoUrls);
                                }
                              },
                            ),
                            SizedBox(width: 5),
                            CustomIconButton(
                              icon: Assets.images.svg.video
                                  .svg(color: Color(0xFF73777B)),
                              onTap: () async {
                                final videoUrl = await singleVideoPick(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AppConfirmationDialog(
                                    content: "Please choose thumnail for video",
                                    onConfirmClicked: () async {
                                      final thumnail =
                                          await singleImagePick(context);
                                      bloc.updateField(
                                        videoUrl: videoUrl,
                                        videoThumbnail: thumnail,
                                      );
                                      Navigator.pop(context);
                                    },
                                    onCancelClicked: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        //? Submit
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
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
                          },
                          child: const Text('Submit'),
                        ),
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
                child: Image.file(File(imageData), fit: BoxFit.cover));
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
            file: videoPath,
          ),
        );
      },
    );
  }
}
