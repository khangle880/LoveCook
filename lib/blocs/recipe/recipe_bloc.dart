import '../../extensions/extensions.dart';

import '../../../core/base/base_response.dart';
import '../../../data/enum.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../widgets/pagination_widget/pagination_helper.dart';
import '../../utils/utils.dart';
import 'recipe_state.dart';

class RecipeBloc extends BaseBloc<RecipeState> {
  final IRecipeRepository _recipeRepository;
  final ISearchRepository _searchRepository;
  final ILookupRepository _lookupRepository;
  PaginationHelper<RecipeModel>? paginationHelper;
  RecipeBloc(
    this._recipeRepository,
    this._searchRepository,
    this._lookupRepository,
  );

  setUser(User user) {
    emit((state ?? RecipeState()).copyWith(user: user));
  }

  init() async {
    final responseEither = await _lookupRepository.getLookup();
    responseEither.fold((failure) {}, (data) {
      emit((state ?? RecipeState()).copyWith(lookup: data.item));
    });
  }

  Future<PagingListResponse<RecipeModel>> getRecipes(
      {required int page}) async {
    Map<String, dynamic> queryParams = {
      'page': page,
      'type': SearchType.recipe.shortString,
    };
    if (state?.user != null) queryParams.putIfAbsent('creatorId', () => state!.user!.id);
    if (state?.query != null && state!.query!.isNotEmpty)
      queryParams.putIfAbsent('q', () => state!.query);
    if (state?.level != null)
      queryParams.putIfAbsent('level', () => state!.level!.shortString);
    if (state?.cuisine != null)
      queryParams.putIfAbsent('cuisineId', () => state!.cuisine!.id);
    if (state?.dishType != null)
      queryParams.putIfAbsent('dishTypeId', () => state!.dishType!.id);
    final responseEither = await _searchRepository.search(query: queryParams);
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

  void updateFilter({
    Nullable<Level?>? level,
    Nullable<CuisineModel?>? cuisine,
    Nullable<DishTypeModel?>? dishType,
    Nullable<String?>? query,
  }) {
    emit((state ?? RecipeState()).copyWith(
        level: level, cuisine: cuisine, dishType: dishType, query: query));
  }

  @override
  void dispose() {
    super.dispose();
    paginationHelper = null;
  }
}
