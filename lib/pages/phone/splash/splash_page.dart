import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../extensions/extensions.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../gen/assets.gen.dart';
import '../../../resources/resources.dart';
import '../../../router/router.dart';

class SplashPage extends StatefulWidget {
  final SplashBloc bloc;

  SplashPage(this.bloc);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashBloc> {
  @override
  SplashBloc get bloc => widget.bloc;

  @override
  void initData() {
    super.initData();
    bloc.checkToken();
  }

  // override this function to get data from previous page
  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
  }

  // @override
  // Widget? buildAppBar(BuildContext context) {
  //   return AppBar(
  //     title: Text(localization.change_language),
  //     automaticallyImplyLeading: false,
  //   );
  // }

  // @override
  // Widget? buildFloatingActionButton(BuildContext context) {
  //   return FloatingActionButton(
  //     onPressed: () async {
  //       // bloc.loadData();
  //       // final prefs = GetIt.I.get<SharedPreferences>();
  //       // final appBloc = GetIt.I.get<AppBloc>();
  //       // final languageCode = prefs.getString(SharedPreferencesKey.languageCode);
  //       // if (languageCode == 'ko') {
  //       //   appBloc.changeLanguage('en');
  //       // } else {
  //       //   appBloc.changeLanguage('ko');
  //       // }
  //     },
  //     child: Icon(Icons.language),
  //   );
  // }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarken,
      body: Column(
        children: [
          Expanded(flex: 2, child: SizedBox()),
          Center(
            child: Assets.images.svg.logoApp.svg(height: 56),
          ),
          SizedBox(height: 18),
          'Love Cook'.s15w700(color: AppColors.whiteLight),
          Expanded(flex: 3, child: SizedBox()),
        ],
      ),
    );
  }

  @override
  void blocListener(state) {
    if (mounted) {
      super.blocListener(state);
      switch (state.status ?? SplashStatus.loading_data) {
        case SplashStatus.authenticated:
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
          break;
        case SplashStatus.not_authenticated:
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
          break;
        default:
          break;
      }
    }
  }
}
