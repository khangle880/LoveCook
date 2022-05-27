import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/core.dart';

class NetworkDependencies {
  static Future setup(GetIt injector) async {
    final authorizationInterceptor = AuthorizationInterceptor();

    // network checker
    injector.registerLazySingleton(() => InternetConnectionChecker());
    injector.registerLazySingleton<INetworkInfo>(() => NetworkInfo(injector()));

    // network utility for request
    injector.registerLazySingleton<INetworkUtility>(
      () => NetworkUtility(
        'BASE_URL',
        interceptors: [authorizationInterceptor],
      ),
      instanceName: NetworkConstant.authorizationDomain,
    );
  }
}
