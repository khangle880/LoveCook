import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'blocs/blocs.dart';
import 'dependencies/app_dependencies.dart';
import 'enums.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppDependencies.init(env: Environment.dev);
  runApp(App(bloc: GetIt.I.get<AppBloc>()));
}
