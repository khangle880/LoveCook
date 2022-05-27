import 'package:get_it/get_it.dart';

import '../blocs/blocs.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerLazySingleton(() => AppBloc());
    injector.registerFactory<SplashBloc>(() => SplashBloc(injector()));
  }
}
