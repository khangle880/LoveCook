import '../../extensions/extensions.dart';

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
  RecipeBloc(
    this._recipeRepository,
    this._searchRepository,
  );

  Future<PagingListResponse<RecipeModel>> getRecipes(
      {String? query, required int page}) async {
    if (query != null && query.isNotEmpty) {
      final responseEither = await _searchRepository.search(
          query: query, searchType: SearchType.recipe, page: page);
      return responseEither.fold((failure) {
        return Future.error(failure);
      }, (data) {
        return data.item!.recipes!;
      });
    }
    final responseEither =
        await _recipeRepository.getRecipes(query: {'page': page});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<bool> handleLikeRecipe(RecipeModel recipe, bool liked) {
    final handleLikeFunction =
        liked ? _recipeRepository.like : _recipeRepository.dislike;

    return handleLikeFunction(recipeId: recipe.id!).then((value) {
      int likeCount = recipe.totalLikes ?? 0;
      likeCount = liked ? likeCount + 1 : likeCount - 1;
      final newRecipe = recipe.copyWith(isLiked: liked, totalLikes: likeCount);

      final newList = List<RecipeModel>.from(paginationHelper?.items ?? [])
          .replaceItem(newRecipe, (element) => element.id == newRecipe.id);
      paginationHelper!.updateList(newList);
      return liked;
    }).catchError((e) {
      return !liked;
    });
  }

  void updateItem(RecipeModel? recipe) async {
    if (recipe == null) return;
    final index = (paginationHelper?.items ?? [])
        .indexWhere((element) => element.id == recipe.id);
    var newList;
    if (index == -1) {
      newList = List<RecipeModel>.from(paginationHelper?.items ?? [])
        ..insert(0, recipe);
    } else {
      newList = List<RecipeModel>.from(paginationHelper?.items ?? [])
          .replaceItem(recipe, (element) => element.id == recipe.id);
    }

    paginationHelper!.updateList(newList);
  }

  @override
  void dispose() {
    super.dispose();
    paginationHelper = null;
  }
}
