import 'package:get_it/get_it.dart';
import '../pages/phone/test_api/test_api_bloc.dart';

import '../blocs/blocs.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerLazySingleton(() => AppBloc());
    injector.registerFactory<SplashBloc>(
        () => SplashBloc(injector(), injector(), injector()));
    injector
        .registerFactory<LoginBloc>(() => LoginBloc(injector(), injector()));
    injector.registerFactory<TestApiBloc>(() => TestApiBloc(
          injector(),
          injector(),
          injector(),
          injector(),
          injector(),
          injector(),
          injector(),
          injector(),
        ));
    injector.registerFactory<ChatBloc>(() => ChatBloc(injector()));
    injector.registerFactory<ProfileBloc>(
        () => ProfileBloc(injector(), injector()));
    injector.registerFactory<RecipeBloc>(
        () => RecipeBloc(injector(), injector(), injector()));
    injector.registerFactory<RecipeDetailBloc>(
        () => RecipeDetailBloc(injector(), injector()));
    injector.registerFactory<AddRecipeBloc>(
        () => AddRecipeBloc(injector(), injector(), injector()));
    injector.registerFactory<ProductBloc>(
        () => ProductBloc(injector(), injector()));
    injector.registerFactory<AddProductBloc>(
        () => AddProductBloc(injector(), injector(), injector()));
    injector.registerFactory<FeedBloc>(
        () => FeedBloc(injector(), injector(), injector()));
    injector
        .registerFactory<FeedCommentBloc>(() => FeedCommentBloc(injector()));
  }
}
