import 'package:get_it/get_it.dart';

import '../data/data.dart';

class RepositoryDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ISplashRepository>(() => SplashRepository(
          remoteService: injector(),
          localService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ILoginRepository>(() => LoginRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IChatRepository>(() =>
        ChatRepository(networkInfo: injector(), remoteService: injector()));
  }
}
