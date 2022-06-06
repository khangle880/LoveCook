import 'package:lovecook/core/base/base.dart';
import 'package:lovecook/data/data.dart';

import 'add_recipe_state.dart';

class AddRecipeBloc extends BaseBloc<AddRecipeState> {
  final RecipeRepository _recipeRepository;
  AddRecipeBloc(this._recipeRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  @override
  void dispose() {
    super.dispose();
  }
}
