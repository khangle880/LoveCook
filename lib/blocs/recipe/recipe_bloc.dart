import 'package:lovecook/extensions/extensions.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/base/base_response.dart';
import '../../../data/enum.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../widgets/pagination_widget/pagination_helper.dart';
import 'recipe_state.dart';

class RecipeBloc extends BaseBloc<RecipeState> {
  final IRecipeRepository _recipeRepository;
  final ISearchRepository _searchRepository;
  PaginationHelper<RecipeModel>? paginationHelper;
  BehaviorSubject<List<RecipeModel>?> bsRecipes = BehaviorSubject.seeded(null);
  RecipeBloc(
    this._recipeRepository,
    this._searchRepository,
  );

  Future<PagingListResponse> getRecipes({required int page}) async {
    final responseEither =
        await _recipeRepository.getRecipes(query: {'page': page});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<PagingListResponse<RecipeModel>> getSearch(
      {required String text, required int page}) async {
    final responseEither = await _searchRepository.search(
        query: text, searchType: SearchType.recipe, page: page);
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item!.recipes!;
    });
  }

  Future<bool> handleLikeRecipe(RecipeModel recipe, bool liked) {
    final handleLikeFunction =
        liked ? _recipeRepository.like : _recipeRepository.dislike;

    return handleLikeFunction(recipeId: recipe.id!).then((value) {
      int likeCount = recipe.totalLikes ?? 0;
      likeCount = liked ? likeCount + 1 : likeCount - 1;
      final newRecipe = recipe.copyWith(isLiked: liked, totalLikes: likeCount);

      final newList = List<RecipeModel>.from(bsRecipes.value ?? [])
          .replaceItem(newRecipe, (element) => element.id == newRecipe.id);
      bsRecipes.add(newList);
      paginationHelper!.updateList(newList);
      return liked;
    }).catchError((e) {
      return !liked;
    });
  }

  void updateItem(RecipeModel? recipe) async {
    if (recipe == null) return;
    final index = (bsRecipes.value ?? [])
        .indexWhere((element) => element.id == recipe.id);
    var newList;
    if (index == -1) {
      newList = List<RecipeModel>.from(bsRecipes.value ?? [])
        ..insert(0, recipe);
    } else {
      newList = List<RecipeModel>.from(bsRecipes.value ?? [])
          .replaceItem(recipe, (element) => element.id == recipe.id);
    }

    bsRecipes.add(newList);
    paginationHelper!.updateList(newList);
  }

  @override
  void dispose() {
    super.dispose();
    paginationHelper = null;
    bsRecipes.drain();
    bsRecipes.close();
  }
}
