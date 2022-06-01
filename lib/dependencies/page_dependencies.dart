import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../pages/pages.dart';
import '../pages/phone/home/home_page.dart';
import '../pages/phone/test_api/test_api_page.dart';
import '../router/router.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => SplashPage(injector()),
        instanceName: Routes.splash);
    injector.registerFactory<Widget>(() => LoginPage(injector()),
        instanceName: Routes.login);
    injector.registerFactory<Widget>(() => HomePage(injector(), injector()),
        instanceName: Routes.home);
    injector.registerFactory<Widget>(() => TestApiPage(injector()),
        instanceName: Routes.testApi);
    injector.registerFactory<Widget>(() => ChatPage(injector()));
    injector.registerFactory<Widget>(() => ProfilePage(injector()));
  }
}
