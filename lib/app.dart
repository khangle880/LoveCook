import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/blocs.dart';
import 'generated/l10n.dart';
import 'router/router.dart';

class App extends StatefulWidget {
  final AppBloc bloc;

  App({Key? key, required this.bloc}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppState>(
        stream: widget.bloc.stateStream,
        builder: (context, snapshot) {
          return _buildApp(state: snapshot.data);
        });
  }

  Widget _buildApp({AppState? state}) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: (settings) => Routes.getRoute(settings),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: state?.locale,
    );
  }
}
