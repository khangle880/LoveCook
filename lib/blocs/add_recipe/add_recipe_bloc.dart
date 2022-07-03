import 'package:dartz/dartz.dart';
import '../../core/base/base.dart';
import '../../data/data.dart';

import '../../data/enum.dart';
import 'add_recipe_state.dart';

class AddRecipeBloc extends BaseBloc<AddRecipeState> {
  final IRecipeRepository _recipeRepository;
  final ILookupRepository _lookupRepository;
  final IUploadRepository _uploadRepository;
  AddRecipeBloc(
      this._recipeRepository, this._lookupRepository, this._uploadRepository);

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

  Future<String> uploadVideo(String filePath) async {
    final imageResponseEither =
        await _uploadRepository.uploadVideoData(filePath: filePath);
    return imageResponseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item?.urls?[0] ?? '';
    });
  }

  Future<String> uploadImage(String filePath) async {
    final imageResponseEither =
        await _uploadRepository.uploadFileData(filePath: filePath);
    return imageResponseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item?.urls?[0] ?? '';
    });
  }

  Future saveRecipe() async {
    emitWaiting(true);
    var map = {
      'description': state?.description,
      'name': state?.name,
      'servings': state?.servings,
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
    if (state?.photoUrls != null) {
      map['photoUrls'] = await Future.wait(state!.photoUrls!.map((e) async {
        if (!e.contains('/v1/')) {
          return await uploadImage(e);
        }
        return e;
      }));
    }
    if (state?.videoUrl != null) {
      map['videoUrl'] = !state!.videoUrl!.contains('/v1/')
          ? await uploadVideo(state!.videoUrl!)
          : state!.videoUrl;
      map['videoThumbnail'] = !state!.videoThumbnail!.contains('/v1/')
          ? await uploadImage(state!.videoThumbnail!)
          : state!.videoThumbnail;
    }
    final List<Map<String, dynamic>> steps = [];
    if ((state?.steps ?? []).isNotEmpty) {
      await Future.forEach<CookStepModel>(state!.steps!, (step) async {
        if ((step.photoUrls ?? []).isNotEmpty) {
          final photoUrls = await Future.wait(step.photoUrls!.map((e) async {
            if (!e.contains('/v1/')) {
              return await uploadImage(e);
            }
            return e;
          }));
          steps.add({'content': step.content, 'photoUrls': photoUrls});
        }
      });
    }
    if (steps.isNotEmpty) {
      map['steps'] = steps;
    }

    map.removeWhere((key, value) => value == null);
    Either response;
    if (state?.id != null) {
      response =
          await _recipeRepository.update(recipeId: state!.id!, data: map);
    } else {
      response = await _recipeRepository.createRecipe(data: map);
    }

    emitWaiting(false);
    return response.fold((failure) {
      return Future.error(failure);
    }, (data) {
      if (!data.success) {
        return Future.error(data.error?.errorMessage ?? '');
      }
      return data.item;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
