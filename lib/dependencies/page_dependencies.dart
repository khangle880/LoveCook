import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viiv/pages/phone/home/home_page.dart';

import '../pages/pages.dart';
import '../router/router.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => SplashPage(injector()),
        instanceName: Routes.splash);
    injector.registerFactory<Widget>(() => LoginPage(injector()),
        instanceName: Routes.login);
    injector.registerFactory<Widget>(() => HomePage(injector()),
        instanceName: Routes.home);
    injector.registerFactory<Widget>(() => ChatPage(injector()));
  }
}
