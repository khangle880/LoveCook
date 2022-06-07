import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base.dart';
import 'package:lovecook/data/data.dart';

import '../../data/enum.dart';
import '../../extensions/extensions.dart';
import 'add_recipe_state.dart';

class AddRecipeBloc extends BaseBloc<AddRecipeState> {
  final IRecipeRepository _recipeRepository;
  final ILookupRepository _lookupRepository;
  AddRecipeBloc(this._recipeRepository, this._lookupRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);
  Stream<LookupModel?> get lookupStream =>
      stateStream.map((event) => event.lookup);

  init() async {
    final responseEither = await _lookupRepository.getLookup();
    responseEither.fold((failure) {}, (data) {
      emit((state ?? AddRecipeState()).copyWith(lookup: data.item));
    });
  }

  loadRecipe(RecipeModel recipe) async {
    emit((state ?? AddRecipeState()).copyWith(
      id: recipe.id,
      name: recipe.name,
      description: recipe.description,
      photoUrls: recipe.photoUrls,
      servings: recipe.servings,
      steps: recipe.steps,
      totalTime: recipe.totalTime,
      level: recipe.level,
      videoUrl: recipe.videoUrl,
      videoThumbnail: recipe.videoThumbnail,
      ingredients: recipe.ingredients,
      specialGoals: recipe.specialGoals,
      menuTypes: recipe.menuTypes,
      cuisine: recipe.cuisine,
      dishType: recipe.dishType,
      cookMethod: recipe.cookMethod,
    ));
    init();
  }

  updateField({
    String? name,
    String? description,
    List<String>? photoUrls,
    int? servings,
    List<CookStepModel>? steps,
    double? totalTime,
    Level? level,
    String? videoUrl,
    String? videoThumbnail,
    List<IngredientModel>? ingredients,
    List<SpecialGoalModel>? specialGoals,
    List<MenuTypeModel>? menuTypes,
    CuisineModel? cuisine,
    DishTypeModel? dishType,
    CookMethodModel? cookMethod,
  }) {
    emit((state ?? AddRecipeState()).copyWith(
      name: name,
      description: description,
      photoUrls: photoUrls,
      servings: servings,
      steps: steps,
      totalTime: totalTime,
      level: level,
      videoUrl: videoUrl,
      videoThumbnail: videoThumbnail,
      ingredients: ingredients,
      specialGoals: specialGoals,
      menuTypes: menuTypes,
      cuisine: cuisine,
      dishType: dishType,
      cookMethod: cookMethod,
    ));
  }

  Future<RecipeModel> saveRecipe() async {
    emitWaiting(true);
    final map = {
      'description': state?.description,
      'name': state?.name,
      // TODO: this is spam
      'photoUrls': List.from(["/v1/photos/629ad0dc20ca36e40e94f1e6"]),
      'servings': state?.servings,
      'steps': state?.steps
          ?.map((e) => {
                'content': e.content,
                // TODO: add photo
              })
          .toList(),
      'totalTime': state?.totalTime,
      'level': state?.level?.shortString,
      'videoUrl': state?.videoUrl,
      'videoThumbnail': state?.videoThumbnail,
      'ingredients': state?.ingredients
          ?.map((e) => {
                "name": e.name,
                "typeId": e.type?.id,
                "unitId": e.unit?.id,
                "quantity": e.quantity,
              })
          .toList(),
      'specialGoals': state?.specialGoals?.map((e) => e.id).toList(),
      'menuTypes': state?.menuTypes?.map((e) => e.id).toList(),
      'cuisineId': state?.cuisine?.id,
      'dishTypeId': state?.dishType?.id,
      'cookMethodId': state?.cookMethod?.id,
    };

    map.removeWhere((key, value) => value == null);
    Either response;
    if (state?.id != null) {
      response =
          await _recipeRepository.update(recipeId: state!.id!, data: map);
    } else {
      response = await _recipeRepository.createRecipe(data: map);
    }

    return response.fold((failure) {
      emitWaiting(false);
      return Future.error(failure);
    }, (data) {
      emitWaiting(false);
      return data.item;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
