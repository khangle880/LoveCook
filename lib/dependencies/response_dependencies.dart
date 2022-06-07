import 'package:get_it/get_it.dart';
import '../data/data.dart';

class ResponseDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<LoginModel>(() => LoginModel());
    injector.registerFactory<CommentModel>(() => CommentModel());
    injector.registerFactory<SpecialGoalModel>(() => SpecialGoalModel());
    injector.registerFactory<MenuTypeModel>(() => MenuTypeModel());
    injector.registerFactory<CuisineModel>(() => CuisineModel());
    injector.registerFactory<DishTypeModel>(() => DishTypeModel());
    injector.registerFactory<IngredientTypeModel>(() => IngredientTypeModel());
    injector.registerFactory<ProductTypeModel>(() => ProductTypeModel());
    injector.registerFactory<UnitModel>(() => UnitModel());
    injector.registerFactory<CookMethodModel>(() => CookMethodModel());
    injector.registerFactory<LookupModel>(() => LookupModel());
    injector.registerFactory<PostModel>(() => PostModel());
    injector.registerFactory<ProductModel>(() => ProductModel());
    injector.registerFactory<RecipeModel>(() => RecipeModel());
    injector.registerFactory<RatingModel>(() => RatingModel());
    injector.registerFactory<ReactionModel>(() => ReactionModel());
    injector.registerFactory<SearchModel>(() => SearchModel());
    injector.registerFactory<SingleType>(() => SingleType());
    injector.registerFactory<User>(() => User());
  }
}
