import 'package:get_it/get_it.dart';
import '../pages/phone/test_api/test_api_bloc.dart';

import '../blocs/blocs.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerLazySingleton(() => AppBloc());
    injector.registerFactory<SplashBloc>(() => SplashBloc(injector()));
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
  }
}
