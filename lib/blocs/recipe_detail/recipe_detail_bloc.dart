import '../../../core/core.dart';
import '../../../data/data.dart';
import 'recipe_detail_state.dart';

class RecipeDetailBloc extends BaseBloc<RecipeDetailState> {
  final IRecipeRepository _recipeRepository;
  final IUserRepository _userRepository;

  RecipeDetailBloc(this._recipeRepository, this._userRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);
  Stream<RecipeModel?> get recipeStream =>
      stateStream.map((event) => event.recipe);
  Stream<int?> get recipesOfCreator =>
      stateStream.map((event) => event.recipesOfCreator);

  void handleFailedDefault(String? e) {
    emit(RecipeDetailState(state: state, success: false, error: e));
  }

  updateRecipe(RecipeModel recipe) {
    emit(RecipeDetailState(state: state, recipe: recipe));
    loadRecipe(recipe.id!);
    loadOwnRecipe(recipe.creator!.id!);
  }

  loadRecipe(String id) async {
    final responseEither = await _recipeRepository.getById(recipeId: id);
    responseEither.fold((failure) {
      handleFailedDefault(failure.toString());
    }, (data) {
      emit(RecipeDetailState(state: state, recipe: data.item));
    });
  }

  loadOwnRecipe(String userId) async {
    final responseEither =
        await _userRepository.getRecipes(userId: userId, query: {});
    responseEither.fold((failure) {
      handleFailedDefault(failure.toString());
    }, (data) {
      emit(RecipeDetailState(
          state: state, recipesOfUser: data.pagination.totalResults));
    });
  }

  Future<bool> handleLikeRecipe(RecipeModel recipe, bool liked) {
    final handleLikeFunction =
        liked ? _recipeRepository.like : _recipeRepository.dislike;

    return handleLikeFunction(recipeId: recipe.id!).then((value) {
      int likeCount = recipe.totalLikes ?? 0;
      likeCount = liked ? likeCount + 1 : likeCount - 1;
      final newRecipe = recipe.copyWith(isLiked: liked, totalLikes: likeCount);

      emit(RecipeDetailState(state: state, recipe: newRecipe));
      return liked;
    }).catchError((e) {
      return !liked;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
