import 'package:get_it/get_it.dart';

import '../data/data.dart';

class LocalServiceDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ISplashLocalService>(() => SplashLocalService());
  }
}
