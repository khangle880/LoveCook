import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/blocs.dart';
import '../../../constants.dart';
import '../../../core/core.dart';

class SplashPage extends StatefulWidget {
  final SplashBloc bloc;

  SplashPage(this.bloc);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashBloc> {
  @override
  SplashBloc get bloc => widget.bloc;

  // @override
  // bool get isCustomLayout => true;

  @override
  void initData() {
    super.initData();
    bloc.loadData();
  }

  // override this function to get data from previous page
  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
  }

  @override
  Widget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(localization.change_language),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // bloc.loadData();
        // final prefs = GetIt.I.get<SharedPreferences>();
        // final appBloc = GetIt.I.get<AppBloc>();
        // final languageCode = prefs.getString(SharedPreferencesKey.languageCode);
        // if (languageCode == 'ko') {
        //   appBloc.changeLanguage('en');
        // } else {
        //   appBloc.changeLanguage('ko');
        // }
      },
      child: Icon(Icons.language),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    print("buildContent build===========");
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localization.hello_world),
            const SizedBox(
              height: 32,
            ),
            StreamBuilder<bool?>(
                stream: bloc.successStream,
                builder: (context, snapshot) {
                  print("successStream build===========");
                  return Text('${snapshot.data}');
                }),
            const SizedBox(
              height: 32,
            ),
            StreamBuilder<String?>(
                stream: bloc.errorStream,
                builder: (context, snapshot) {
                  print("errorStream build===========");
                  return Text('${snapshot.data}');
                }),
          ],
        ),
      ),
    );
  }
}
