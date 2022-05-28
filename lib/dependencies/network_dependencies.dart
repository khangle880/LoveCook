import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/core.dart';
import '../utils/utils.dart';

class NetworkDependencies {
  static Future setup(GetIt injector) async {
    final authorizationInterceptor = AuthorizationInterceptor(injector());

    // network checker
    injector.registerLazySingleton(() => InternetConnectionChecker());
    injector.registerLazySingleton<INetworkInfo>(() => NetworkInfo(injector()));

    // network utility for request
    injector.registerLazySingleton<INetworkUtility>(
      () => NetworkUtility(
        AppConfig.instance.hostUrl,
        interceptors: [authorizationInterceptor],
      ),
      instanceName: NetworkConstant.authorizationDomain,
    );

    injector.registerLazySingleton<INetworkUtility>(
      () => NetworkUtility(
        AppConfig.instance.hostUrl,
      ),
      instanceName: NetworkConstant.publicDomain,
    );
  }
}
