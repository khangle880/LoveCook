import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'route_arguments.dart';

class Routes {
  static String get splash => '/splash';
  static String get login => '/login';
  static String get home => '/home';
  static String get testApi => '/testApi';
  static String get recipeDetail => '/recipeDetail';
  static String get addRecipe => '/addRecipe';
  static String get addProduct => '/addProduct';
  static String get feedComment => '/feedComment';

  static getRoute(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Builder(
            builder: (context) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                child: Text(
                  '404 NOT FOUND',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      );
    }
    if (settings.arguments is RouteArguments &&
        !(settings.arguments as RouteArguments).opaque) {
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => widget,
        settings: settings.copyWith(
            arguments: (settings.arguments as RouteArguments).data),
      );
    }
    return CupertinoPageRoute(
      builder: (_) => widget,
      settings: settings,
    );
  }
}
